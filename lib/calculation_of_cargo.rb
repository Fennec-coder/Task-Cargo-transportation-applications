module CalculationOfCargo
  def calculate_distance(origin_location, destination)
    source_url = 'https://api.mapbox.com/directions-matrix/v1/mapbox/driving/'

    uri = URI("#{source_url}#{origin_location.to_s.gsub(' ', '')};#{destination.to_s.gsub(' ', '')}")

    params = { access_token: 'pk.eyJ1IjoiZmVubmVjLWNvZGVyIiwiYSI6ImNrcnVqcm1nMzEyd2kyb25wOXpvZGsyYzQifQ.z57wncCzhCu2Bb0RNJDHjA', sources: 0, annotations: 'distance' }

    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    response = res.body if res.is_a?(Net::HTTPSuccess)
    answer_json = JSON.parse(response)['distances'][0][1]
    raise 'The path was not found by the server (API)' if answer_json.nil?

    answer_json.to_i
  end

  # @return [integer]
  def rate(length, width, height, weight)
    cubic_meter = length * width * height
    if cubic_meter > 1
      if weight > 10
        3
      else
        2
      end
    else
      1
    end
  end

  def bringing_the_distance(distance)
    distance_charge = distance / 1000
    distance_charge = 1 if distance_charge < 1
    distance_charge
  end

  def price_of_cargo(request, cargo)
    coefficient_for_cargo = rate(cargo.length.to_i, cargo.width.to_i, cargo.height.to_i, cargo.weight.to_i)
    coefficient_for_cargo * bringing_the_distance(request.distance.to_i)
  end
end