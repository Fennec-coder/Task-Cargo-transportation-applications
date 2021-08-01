# frozen_string_literal: true

class Cargo
  @distance = 0
  @price = 0

  def initialize(weight, length, height)
    @weight = weight
    @length = length
    @height = height
  end

  # @return [Hash{Symbol->Unknown}]
  def get_hash
    { weight: @weight, length: @length, height: @height, distance: @distance, price: @price }
  end
end