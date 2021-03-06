class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :edit, :create, :destroy]
  before_action :is_admin?, only: [:edit]

  
  def index
    @events = Event.where(validated: true)
  end

  def show
    @event = Event.find(params[:id])
    @end_date_time = (@event.start_date + (@event.duration * 60))
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.event_admin = current_user
    @event.validated = false

    if @event.save 
      redirect_to event_path(@event.id), success: "Evénement créé avec succès !"
    else
      flash.now[:alert] = " "
      render :new
    end
  end

  def destroy
    @event = Event.find(params[:id]).destroy
    redirect_to root_path, success: "Evénement supprimé !"

  end

  def is_admin?
      @event = Event.find_by(id: params[:id])
      redirect_to root_path unless @event.is_admin?(current_user)
  end


  private

  def event_params
    params.require(:event).permit(:title, :start_date, :duration, :description, :price, :location, :event_picture)
    
  end

end
