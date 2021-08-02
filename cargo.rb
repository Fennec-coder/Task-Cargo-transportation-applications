# frozen_string_literal: true

require 'net/http'
require 'json'

class Cargo
  SOURCE = 'https://api.mapbox.com/directions-matrix/v1/mapbox/driving/'

  def initialize(weight, length, height, width, origin_location, destination)
    @weight = weight.abs
    @length = length.abs
    @width = width.abs
    @height = height.abs
    @origin_location = origin_location
    @destination = destination
    @path = "#{SOURCE}#{origin_location.to_s.gsub(' ', '')};#{destination.to_s.gsub(' ', '')}"
    @distance = calculate_distance
  end

  # @return [Hash]
  def hash
    { weight: @weight, length: @length, width: @width, height: @height, distance: @distance, price: calculate_price }
  end

  # @return [integer]
  def rate
    cubic_meter = @length * @width * @height
    if cubic_meter > 1
      if @weight > 10
        3
      else
        2
      end
    else
      1
    end
  end

  # @return [string]
  def calculate_distance
    uri = URI(@path)

    params = { access_token: '', sources: 0, annotations: 'distance' }

    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    response = res.body if res.is_a?(Net::HTTPSuccess)
    answer_json = JSON.parse(response)['distances'][0][1]

    raise 'The path was not found by the server (API)' if answer_json.nil?

    answer_json.to_i
  end

  def calculate_price
    distance_charge = @distance / 1000
    distance_charge = 1 if distance_charge < 1

    rate * distance_charge
  end
end