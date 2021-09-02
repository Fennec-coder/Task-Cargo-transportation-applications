require 'calculation_of_cargo'

class RequestsController < ApplicationController
  include CalculationOfCargo
  before_action :authenticate_client!

  def index
    @requests = Request.all
  end

  def show
    @request = Request.find(params[:id])
    @client = Client.find(@request.client_id)
    @price = 0

    Cargo.where(request_id: @request.id).each do |cargo|
      @price += price_of_cargo(@request, cargo)
    end

  end

  def new
    @client = Client.find(params[:client_id])
    @request = Request.new
  end

  # only an application for cargo transportation is created,
  # the cargo itself is added after the application is created,
  # the cargo has an application ID to which it belongs.
  def create
    @request = Request.new(request_params)
    @request.client_id = current_client.id if client_signed_in?

    # I save the distance value because this is a request to a third-party server, it is long.
    # Most likely this is not correct
    @request.distance =calculate_distance(@request.origin_location, @request.destination)
    if @request.save
      redirect_to @request, flash: {success: 'Request was added'}
    else
      render :new, flash: {alert: 'Some error occured'}
    end
  end

  def edit
    @request = Request.find(params[:id])
  end

  def update
    request = Request.find(params[:id])
    request.update(request_params)
    redirect_to request, flash: {success: 'Request was updated'}
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy

    redirect_to client_path(current_client)
  end

  def request_params
    params.require(:request).permit(:origin_location, :destination)
  end

end
