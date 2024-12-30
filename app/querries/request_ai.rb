# frozen_string_literal: true
class RequestAi
  def initialize(thread_id: , message: )
    @thread_id = thread_id
    @message = message
  end

  def call
    send_message
    get_response
  end

  private

  attr_accessor :thread_id, :message

  def send_message
    begin
      @send_message ||= Ai::SendMessage.new(message: message, thread_id: thread_id).call
    rescue Faraday::ConnectionFailed
      Rails.logger.error "Failed to connect to OpenAI"
    end
  end

  def get_response
    begin
      Ai::GetMessages.new(
        thread_id: send_message[:thread_id],
        run_id: send_message[:run_id]
      ).call
    rescue
      "Failed connection, try again later"
    end
  end
end