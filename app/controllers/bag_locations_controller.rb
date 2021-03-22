# frozen_string_literal: true

class BagLocationsController < ApplicationController
  load_and_authorize_resource
  before_action :load_event
  before_action :set_bag_location, only: %i[show edit update destroy]

  # GET /bag_locations or /bag_locations.json
  def index
    @bag_locations = @event.bag_locations
  end

  # GET /bag_locations/1 or /bag_locations/1.json
  def show; end

  # GET /bag_locations/new
  def new
    @bag_location = @event.bag_locations.build
    @bag_location.customer = Customer.new
  end

  # GET /bag_locations/1/edit
  def edit; end

  # POST /bag_locations or /bag_locations.json
  def create
    @bag_location = @event.bag_locations.build(bag_location_params)
    phone = params['bag_location']['customer_attributes']['phone_number']
    formatted_phone = Phonelib.parse(phone.to_s).full_e164.presence
    existing_customer = Customer.find_by_phone_number(formatted_phone)
    @bag_location.customer = existing_customer if existing_customer

    respond_to do |format|
      if @bag_location.save
        format.html { redirect_to event_path(@event), notice: 'Bag location was successfully created.' }
        format.json { render :show, status: :created, location: @bag_location }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bag_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bag_locations/1 or /bag_locations/1.json
  def update
    respond_to do |format|
      if @bag_location.update(bag_location_params)
        format.html { redirect_to event_bag_location_path(@event), notice: 'Bag location was successfully updated.' }
        format.json { render :show, status: :ok, location: @bag_location }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bag_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bag_locations/1 or /bag_locations/1.json
  def destroy
    @bag_location.destroy
    respond_to do |format|
      format.html { redirect_to event_bag_locations_path(@event), notice: 'Bag location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bag_location
    @bag_location = @event.bag_locations.find(params[:id])
  end

  def load_event
    @event = Event.find(params[:event_id])
  end

  # Only allow a list of trusted parameters through.
  def bag_location_params
    params.require(:bag_location).permit(:location, :event_id,
                                         customer_attributes: %i[id event_id first_name last_name phone_number])
  end
end
