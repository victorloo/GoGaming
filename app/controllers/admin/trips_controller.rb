class Admin::TripsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :set_trip, only:[:update, :destroy]
  def index
    @trips = Trip.all

    if params[:id]
      @trip = Trip.find(params[:id])
    else
      @trip = Trip.new
    end
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      flash[:notce] = "已儲存"
      redirect_to admin_trips_path
    else
      flash.now[:alert] = "儲存失敗"
      render :new
    end
  end

  
  def update
     @trip.update(trip_params)
     redirect_to admin_trips_path
  end

  def destroy
     @trip.delete
     redirect_to admin_trips_path
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :gostations_index)
  end

  def set_trip
     @trip = Trip.find(params[:id])
  end
end
