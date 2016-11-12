class ProtestsController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @protest = Protest.find(id) # look up protest by unique ID
  end
  


  def index
    # sort = params[:sort] || session[:sort]
    # case sort
    # when 'title'
    #   ordering,@title_header = {:title => :asc}, 'hilite'
    # when 'event_date'
    #   ordering,@date_header = {:event_date => :asc}, 'hilite'
    # end
    # @protests = [Protest.create(:title => 'BLM', :location => 'Oakland', :description => 'This is a protest')]
    @protests = Protest.all
  end

  def new
    # default: render 'new' template
  end
  
  def protest_params
      params.require(:protest).permit(:title, :description, :event_date, :location)
  end
  
  def create
    Protest.create(protest_params)
    
    # @protest = Protest.create!(params[:protest])
    # flash[:notice] = "#{@protest.title} was successfully created."
    redirect_to protests_path
  end

  def edit
    @protest = Protest.find params[:id]
  end

  def update
    @protest = Protest.find params[:id]
    @protest.update_attributes!(protest_params)
    flash[:notice] = "#{@protest.title} was successfully updated."
    redirect_to protest_path(@protest)
  end

  def destroy
    @protest = Protest.find(params[:id])
    @protest.destroy
    flash[:notice] = "Protest '#{@protest.title}' deleted."
    redirect_to protests_path
  end

end
