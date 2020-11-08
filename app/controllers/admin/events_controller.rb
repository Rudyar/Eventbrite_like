class Admin::EventsController < Admin::BaseController

  def index
    @events = Event.where(validated: false)

  end

  def show
    @event = Event.find(params[:id])
    @end_date_time = (@event.start_date + (@event.duration * 60))
  end

  def update
    @event = Event.find(params[:id])  
    if @event.update(validated: true)
      redirect_to root_path, success: "Evénement validé"
    else
      render :edit, alert: "Impossible de valider l'événement :"
    end
    
  end

  def destroy
    @event = Event.find(params[:id]).destroy
    redirect_to root_path, success: "Evénement supprimé !"

  end


end