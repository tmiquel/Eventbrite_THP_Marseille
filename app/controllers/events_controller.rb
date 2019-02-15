# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy], alert: 'You must sign in first!'
  before_action :admin_only, only: %i[edit update destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    event_creation = event_params.clone
    event_creation[:admin_id] = current_user.id

    @event = Event.new(event_creation)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, alert: "Your event can not be created: #{@event.errors.messages}" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @event = Event.find(params[:id])
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    event_title = @event.title

    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event '#{event_title}' was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def admin_only
    @event = Event.find(params[:id])
    unless @event.admin == current_user
      redirect_to root_url, alert: 'Modifying the event of another user is forbidden.'
    end
  end

  # # Use callbacks to share common setup or constraints between actions.
  # def set_event
  #   @event = Event.find(params[:id])
  # end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:admin_id, :start_date, :duration, :title, :description, :price, :location)
  end
end
