class Admin::EventsController < Admin::BaseController

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @end_date_time = (@event.start_date + (@event.duration * 60))
  end

  def create
    @event = Event.new(event_params)
    @event.event_admin = current_user

    if @event.save 
      redirect_to event_path(@event.id), success: "Evénement créé avec succès !"
    else
      render :new
    end
  end

  def destroy
    @event = Event.find(params[:id]).destroy
    redirect_to root_path, success: "Evénment supprimé !"

  end

  private

  def event_params
    params.require(:event).permit(:title, :start_date, :duration, :description, :price, :location, :event_picture)
    
  end

end