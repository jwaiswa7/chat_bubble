module Ai
  class Thread < Base
    def call
      { thread_id: thread_id }
    end

    private

    def thread
      begin
        @thread ||= client.threads.create
      rescue Faraday::ConnectionFailed
        Rails.logger.error "Failed to connect to OpenAI"
      end
    end

    def thread_id
      thread['id'] rescue nil
    end
  end
end