# frozen_string_literal: true

class AttendancesController < ApplicationController
  before_action :set_attendance, only: %i[show edit update destroy]

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
    @event = Event.find(params[:event_id])
    @striprice = @event.price*100
    @attendance
  end

  def create
    @event = Event.find(params[:event_id])
    @striprice = @event.price*100

    customer = Stripe::Customer.create(
    :email => params[:stripeEmail],
    :source  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @striprice,
    :description => 'Rails Stripe customer',
    :currency    => 'usd'
  )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_event_attendance_path(@event)
    
    if customer&&charge
      att = Attendance.create(attendee: current_user, event: @event, stripe_customer_id: charge.customer)
      redirect_to root_path
    else
      redirect_to new_event_attendance_path(@event)
    end

end




  # def new
  #   # event = Event.first

  #   @attendance = Attendance.new(attendee_id: current_user.id, event_id: params[event.id], stripe_customer_id: rand(10))
  #   if @attendance.save
  #     redirect_to event_path(@attendance.event.id), notice: 'Attendance was successfully created.'
  #   else
  #     redirect_to event_path(@attendance.event.id), alert: 'Error. Attendance has not been created!'
  #   end
  # end

  # # GET /attendances/1/edit
  # def edit; end

  # # POST /attendances
  # # POST /attendances.json
  # def create
  #   byebug

  #   event = Event.first

  #   @attendance = Attendance.new(attendee_id: current_user.id, event_id: event, stripe_customer_id: rand(10))

  #   respond_to do |format|
  #     if @attendance.save
  #       format.html { redirect_to @attendance, notice: 'Attendance was successfully created.' }
  #       format.json { render :show, status: :created, location: @attendance }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @attendance.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

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
end
