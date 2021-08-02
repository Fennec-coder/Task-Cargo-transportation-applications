# frozen_string_literal: true
require_relative 'cargo'
require_relative 'test'

class CargoTest < Test
  # It is known in advance that the distance between the coordinates is 395 meters,
  # the data is taken from an external source.
  #
  def test_the_correctness_of_the_hash_output
    cargo = Cargo.new(1, 1, 1, 1, '44.591394582046384, 33.48680843596816', '44.59156593952507, 33.491252949511036')
    assert_true(cargo.hash == { weight: 1, length: 1, width: 1, height: 1, distance: 395, price: 1 })
  end

  def test_if_the_load_is_more_than_a_cubic_meter
    cargo = Cargo.new(1, 2, 1, 1, '44.591394582046384, 33.48680843596816', '44.59156593952507, 33.491252949511036')
    assert_true(cargo.calculate_price == 2)
  end

  def test_if_the_weight_is_less_than_zero
    cargo = Cargo.new(-1, 1, 1, 1, '44.591394582046384, 33.48680843596816', '44.59156593952507, 33.491252949511036')
    assert_true(cargo.calculate_price == 1)
  end

  def test_if_the_load_is_more_than_a_cubic_meter_and_weighs_more_than_ten_kilograms
    cargo = Cargo.new(11, 2, 1, 1, '44.591394582046384, 33.48680843596816', '44.59156593952507, 33.491252949511036')
    assert_true(cargo.calculate_price == 3)
  end
end

test = CargoTest.new
test.run
