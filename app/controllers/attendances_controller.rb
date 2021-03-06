class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :amounts
  before_action :is_admin?, only: [:index]
  before_action :can_subscribe?

  
  def new
  end
  
  def create
  
    begin
      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken],
      })
      
      charge = Stripe::Charge.create({
        customer: customer.id,
        amount: @stripe_amount,
        description: 'Rails Stripe customer',
        currency: 'eur',
        })
        
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_event_attendance_path
    end
    
    Attendance.create(user: current_user, event: @event, stripe_customer_id: customer.id)
  
  end
  
  def index
    @event = Event.find_by(id: params[:event_id])
    @attendances = @event.attendances
    
  end
  
  def can_subscribe?
      @event = Event.find_by(id: params[:event_id])
      if @event.users.select{ |user| user == current_user }.count == 0
        return true
      else
        redirect_to event_path(@event), danger: "Tu es déjà inscrit !"
      end
  end
  
  def is_admin?
      @event = Event.find_by(id: params[:event_id])
      redirect_to root_path unless @event.is_admin?(current_user)
  end

  private
  
  def amounts
    @event = Event.find(params[:event_id])
    @amount = @event.price 
    @stripe_amount = @amount * 100
  end 
  
  
end
