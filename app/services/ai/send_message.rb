# frozen_string_literal: true
module Ai
  class SendMessage < Base

    def initialize(message:, thread_id:)
      @message = message
      @thread_id = thread_id
    end

    def call
      build_message
      {
        thread_id: thread_id,
        run_id: run_id
      }
    end

    private

    attr_accessor :thread_id, :message

    def build_message
      @build_message ||= client.messages.create(
        thread_id: thread_id,
        parameters: {
            role: "user",
            content: message,
        }
      )
    end

    def run_id
      @run_id ||= client.runs.create(thread_id: thread_id,
        parameters: {
            assistant_id: ENV.fetch('OPENAI_ASSISTANT_ID')
        })['id']
    end
  end
end