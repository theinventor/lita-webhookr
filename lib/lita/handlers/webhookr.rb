require "lita"

module Lita
  module Handlers
    class WebHookr < Handler

      def self.default_config(config)
        config.repos = {}
      end

      http.get "/webhookr", :receive

      def receive(request, response)
        event_type = request.env['HTTP_X_GITHUB_EVENT'] || 'unknown'
        if event_type == "push"
          payload = parse_payload(request.params['payload']) or return
          repo = get_repo(payload)
          notify_rooms(repo, payload)
        elsif event_type == "ping"
          response.status = 200
          response.write "Working!"

        else
          response.status = 404
        end
      end

      private

      def parse_payload(payload)
        MultiJson.load(payload)
      rescue MultiJson::LoadError => e
        Lita.logger.error("Could not parse JSON payload from Github: #{e.message}")
        return
      end

      def notify_rooms(repo, payload)
        rooms = rooms_for_repo(repo) or return
        message = format_message(payload)

        rooms.each do |room|
          target = Source.new(room: room)
          robot.send_message(target, message)
        end
      end

      def format_message(payload)
        if payload['commits'].size > 0
          "[GitHub] Got #{payload['commits'].size} new commits from #{payload['commits'].first['author']['name']} on #{payload['repository']['owner']['name']}/#{payload['repository']['name']}"
        elsif payload['created']
          "[GitHub] #{payload['pusher']['name']} created: #{payload['ref']}: #{payload['base_ref']}"
        elsif payload['deleted']
          "[GitHub] #{payload['pusher']['name']} deleted: #{payload['ref']}"
        end
      rescue
        Lita.logger.warn "Error formatting message for #{repo} repo. Payload: #{payload}"
        return
      end

      def rooms_for_repo(repo)
        rooms = Lita.config.handlers.github_commits.repos[repo]

        if rooms
          Array(rooms)
        else
          Lita.logger.warn "Notification from GitHub Commits for unconfigured project: #{repo}"
          return
        end
      end


      def get_repo(payload)
        "#{payload['repository']['owner']['name']}/#{payload['repository']['name']}"
      end

    end

    Lita.register_handler(WebHookr)
  end
end
