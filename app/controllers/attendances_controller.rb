# frozen_string_literal: true

class AttendancesController < ApplicationController
  before_action :set_event
  before_action :set_attendance, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :attendee_or_admin, only: [:index]
  before_action :current_attendee_or_admin, only: %i[update destroy]

  # GET /attendances
  # GET /attendances.json
  def index
    @attendances = Attendance.all
  end

  # GET /attendances/1
  # GET /attendances/1.json
  def show; end

  # GET /attendances/new
  def new
    # @event = Event.find(params[:event_id])
    @attendance = Attendance.new(attendee: current_user, event: @event, stripe_customer_id: '1111111111')
    puts '$' * 50
    puts
    tp @attendance
    puts @attendance.errors.messages
    puts
  end

  def create
    # @event = Event.find(params[:event_id])

    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'eur'
    )

    @attendance = Attendance.new(stripe_customer_id: charge.customer,
                                 attendee: current_user,
                                 event_id: params[:event_id])

    if @attendance.save!
      redirect_to @event, notice: 'You have successfully registered to this event.'
    else
      redirect_to new_event_attendance_path(@event),
                  alert: "Your attendance to this event has been rejected: #{@attendance.errors.messages}"
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_event_attendance_path(@event), alert: flash[:error]
  end

  # PATCH/PUT /attendances/1
  # PATCH/PUT /attendances/1.json
  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to @attendance, notice: 'Attendance was successfully updated.' }
        format.json { render :show, status: :ok, location: @attendance }
      else
        format.html { render :edit }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendances/1
  # DELETE /attendances/1.json
  def destroy
    @attendance.destroy
    respond_to do |format|
      format.html { redirect_to attendances_url, notice: 'Attendance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def attendance_params
    params.require(:attendance).permit(:event_id, :attendee_id, :stripe_customer_id)
  end

  def attendee_or_admin
    unless (@event.admin == current_user) || @event.attendees.include?(current_user)
      flash[:danger] = 'Back off ! Not your event !'
      redirect_to root_path, notice: 'You need to attend or manage this event to see the list of attendees.'
    end
  end

  def current_attendee_or_admin
    unless (@event.admin == current_user) || (@eattendance.attendee == current_user)
      flash[:danger] = 'Back off ! Not your event !'
      redirect_to root_path, notice: 'You can only modify your own attendances, or attendances of your own event.'
    end
  end

  def set_event
    @event = Event.find(params[:event_id])
    @amount = @event.price * 100
  end
end
