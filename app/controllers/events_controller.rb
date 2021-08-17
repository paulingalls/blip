# frozen_string_literal: true

class EventsController < ApplicationController
  load_and_authorize_resource
  before_action :set_event, only: %i[show edit update destroy]

  # GET /events or /events.json
  def index; end

  # GET /events/1 or /events/1.json
  def show; end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit; end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Get /events/closing
  def closing
    errors = []
    @event.bag_locations.each do |bag_location|
      bag_location.remind_customer
    rescue StandardError => e
      errors.append(e.message)
    end
    respond_to do |format|
      format.html do
        redirect_to @event, notice: "Reminders sent.  #{errors.empty? ? '' : "Errors: #{errors}"}"
      end
      format.json { head :no_content }
    end
  end

  def complete
    @event.locked = true
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully locked.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:name, :date, :cost, :locked)
  end
end
