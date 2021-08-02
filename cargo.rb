# frozen_string_literal: true

require 'net/http'
require 'json'

class Cargo
  SOURCE = 'https://api.mapbox.com/directions-matrix/v1/mapbox/driving/'

  def initialize(weight, length, height, width, origin_location, destination)
    @weight = weight
    @length = length
    @width = width
    @height = height
    @origin_location = origin_location
    @destination = destination
    @path = "#{SOURCE}#{origin_location.to_s.gsub(' ', '')};#{destination.to_s.gsub(' ', '')}"
  end

  # @return [Hash]
  def hash
    { weight: @weight, length: @length, width: @width, height: @height, distance: calculate_distance, price: calculate_price }
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

    params = {
      access_token: 'pk.eyJ1IjoiZmVubmVjLWNvZGVyIiwiYSI6ImNrcnRudmdzODFpcGYydnBmOGpna2htYXgifQ.GvgVdsIEcDTvmAyvi4p6MA',
      sources: 0,
      annotations: 'distance'
    }

    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    answer = res.body if res.is_a?(Net::HTTPSuccess)
    JSON.parse(answer)['distances'][0][1].to_i
  end

  def calculate_price
    rate * (calculate_distance.to_i / 100)
  end
end

# create obj:
# Cargo.new(11, 100, 2, 2,
#           '44.60209193847771, 33.525387160183136', '44.605040492759855,33.52721106226844')