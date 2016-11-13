class ProtestsController < ApplicationController

  before_filter :authenticate_user!, except: [ :index, :show ]

  def googleVerify
    # render "protests/googleVerify.html"
    render html: "google-site-verification: google27b5178361bfde3d.html"
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @protest = Protest.find(id) # look up protest by unique ID
    @search = $client.search("#protest -rt", :lang => "en").take(5).collect 
  end
  
  def index
    @protests = []
    sort = params[:sort] || session[:sort]
    case sort
    when 'title'
      ordering,@title_header = {:title => :asc}, 'hilite'
    when 'description'
      ordering,@description_header = {:description => :asc}, 'hilite'
    when 'event_date'
      ordering,@date_header = {:event_date => :asc}, 'hilite'
    when 'location'
      ordering,@location_header = {:location => :asc}, 'hilite'
    end
    @protests = Protest.all.order(ordering)
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
