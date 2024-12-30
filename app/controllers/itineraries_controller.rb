# frozen_string_literal: true
class ItinerariesController < ApplicationController
  before_action :set_itinerary, only: %i[show edit run update destroy]

  def new
    @itinerary = Itinerary.new
  end

  def create
    @itinerary = Itinerary.new(itinerary_params)
    respond_to do |format|
      format.turbo_stream do
        if @itinerary.save
          RequestAi.new(itinerary_id: @itinerary.id).call
          render turbo_stream: turbo_stream.replace(
            'ai-form', partial: "itineraries/itinerary",
            locals: { itinerary: @itinerary }
          )
        else
          render turbo_stream: turbo_stream.replace(
            @itinerary, partial: "itineraries/form",
            locals: { itinerary: @itinerary }
          )
        end
      end
    end
  end

  def show
    ::Ai::GetMessages.call(itinerary_id: @itinerary.id)
  end

  def run
    respond_to do |format|
      format.json do
        run = ::Ai::GetMessages.call(itinerary_id: @itinerary.id)
        run = false
        if run
          render :run, status: :ok
        else
          render :run, status: :unprocessable_entity
        end
      end
    end
  end

  private

  def set_itinerary
    @itinerary = Itinerary.find(params[:id])
  end

  def itinerary_params
    params.require(:itinerary).permit(
      :start_date,
      :end_date,
      :budget,
      :accomodation_type,
      :engagement_level,
      :weather,
      :notes,
      :number_of_people,
      interest_list: [],
      destination_list: []
    )
  end
end
