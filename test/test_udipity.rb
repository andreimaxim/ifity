require 'minitest_helper'

class TestUdipity < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Udipity::VERSION
  end
end
