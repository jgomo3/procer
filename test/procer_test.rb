require 'minitest/autorun'
require_relative '../lib/procer'

class ProcerTest < Minitest::Test
  def test_classess
    assert Numeric.to_proc.(0)
    refute Numeric.to_proc.('hola')
    assert String.to_proc.('hola')
    refute String.to_proc.(0)
  end

  def test_ranges
    assert (1..5).to_proc.(2)
    refute (1..5).to_proc.(-1)
  end

  def test_array
    assert_equal 1, [1,2,3,4,5].to_proc.(0)
    assert_equal 2, [1,2,3,4,5].to_proc.(1)
    assert_equal 3, [1,2,3,4,5].to_proc.(2)
    assert_equal 4, [1,2,3,4,5].to_proc.(3)
    assert_equal 5, [1,2,3,4,5].to_proc.(4)
    assert_nil [1,2,3,4,5].to_proc.(5)
  end

  def test_predefined_to_proc_is_respected
    # Symbol#to_proc should behave as before.
    # It should call a method named as the symbol on the
    # parameter.
    assert_equal self.object_id, :object_id.to_proc.(self)
  end
end
