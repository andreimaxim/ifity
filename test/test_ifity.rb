require 'minitest_helper'

class TestIfity < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ifity::VERSION
  end
end
