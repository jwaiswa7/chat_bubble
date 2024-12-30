# frozen_string_literal: true
module Ai
  class GetMessages < Base

    def initialize(thread_id:, run_id:)
      @run_id = run_id
      @thread_id = thread_id
    end

    def call
      return if run_id.nil? || thread_id.nil?
      run_status
      client_response
    end

    private

    attr_accessor :thread_id, :run_id, :run_successfull

    def client_response
      messages = client.messages.list(thread_id: thread_id, parameters: { order: 'desc' })
      messages['data'][0]['content'][0]['text']['value']
    end

    def run_status
      while true do
        response = client.runs.retrieve(id: run_id, thread_id: thread_id)
        status = response['status']

        case status
        when 'queued', 'in_progress', 'cancelling'
          puts 'Sleeping'
          sleep 3 # Wait one second and poll again
        when 'completed'
          @run_successfull = true
          break # Exit loop and report result to user
        when 'requires_action'
          puts 'action required'
          break # Handle tool calls (see below)
        when 'cancelled', 'failed', 'expired'
          puts response['last_error'].inspect
          break # or `exit`
        else
          puts "Unknown status response: #{status}"
        end
      end
    end
  end
end