class Test
  def run
    tests = methods.select { |method| method.to_s.start_with?("test_") }
    tests.each { |test| send(test) }
  end

  def assert_true(actual)
    assert_equal(true, actual)
  end

  def assert_false(actual)
    assert_equal(false, actual)
  end

  def assert_equal(expected, actual)
    if expected == actual
      puts "#{actual} is #{expected} as expected."
    else
      puts "KAPUTT! #{actual} is not #{expected} as expected."
    end
  end
end