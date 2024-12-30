# frozen_string_literal: true
class ChatCompletion < ApplicationService
  def initialize
    @client = OpenAI::Client.new
  end

  def call
    response = client.chat(
      parameters: {
      model: "gpt-4o", # Required.
      messages: [{ role: "user", content: "Hello!"}], # Required.
      temperature: 0.7,
      }
    )

    response = JSON.parse(response.to_json, object_class: OpenStruct)

    response.choices[0].message.content
  end

  attr_accessor :client
end