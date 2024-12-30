# frozen_string_literal: true

class RequestAiJob < ApplicationJob

  queue_as :default

  def perform(thread_id, message)
    response = RequestAi.new(thread_id: thread_id, message: message).call
    Turbo::StreamsChannel.broadcast_replace_to(
      "#{thread_id}-messages-stream", # Stream name
      target: "#{thread_id}-aiWaiting", # Turbo Frame ID
      partial: "chats/ai_message", # Partial to render
      locals: { message: response } # Pass data to the partial
    )

    Turbo::StreamsChannel.broadcast_replace_to(
      "#{thread_id}-messages-stream", # Stream name
      target: "#{thread_id}-chat-form", # Turbo Frame ID
      partial: "chats/form", # Partial to render
      locals: { thread_id: thread_id } # Pass data to the partial
    )
  end
end
