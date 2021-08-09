class RequestsController < ApplicationController
  SOURCE = 'https://api.mapbox.com/directions-matrix/v1/mapbox/driving/'

  def index
    @requests = Request.all
  end

  def show
    @request = Request.find(params[:id])
    @client = Client.find(@request.client_id)
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

  def calculate_distance(origin_location, destination)
    uri = URI("#{SOURCE}#{origin_location.to_s.gsub(' ', '')};#{destination.to_s.gsub(' ', '')}")

    params = { access_token: 'pk.eyJ1IjoiZmVubmVjLWNvZGVyIiwiYSI6ImNrcnVqcm1nMzEyd2kyb25wOXpvZGsyYzQifQ.z57wncCzhCu2Bb0RNJDHjA', sources: 0, annotations: 'distance' }

    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    response = res.body if res.is_a?(Net::HTTPSuccess)
    answer_json = JSON.parse(response)['distances'][0][1]
    raise 'The path was not found by the server (API)' if answer_json.nil?

    answer_json.to_i
  end

end
