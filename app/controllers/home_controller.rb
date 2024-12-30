# frozen_string_literal: true
class HomeController < ApplicationController
  def index
    @thread_id = Ai::Thread.call[:thread_id]
  end
end