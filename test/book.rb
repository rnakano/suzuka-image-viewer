require 'minitest/unit'
require 'minitest/autorun'
require './model/book'

class TestBook < MiniTest::Unit::TestCase
  def test_sort_file
    assert_equal(%w!1-1 3-1 10-1!, Book::sort_file(%w!1-1 10-1 3-1!))
    assert_equal(%w!2-1 2-2 11-1!, Book::sort_file(%w!11-1 2-2 2-1!))
    assert_equal(%w!00-1 omake omake2!, Book::sort_file(%w!omake2 omake 00-1!))
  end
end
