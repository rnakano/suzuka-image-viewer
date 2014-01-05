# -*- coding: utf-8 -*-
require 'minitest/unit'
require 'minitest/autorun'
require './model/book'

class TestBook < MiniTest::Unit::TestCase
  def test_sort_file
    assert_equal(%w!1-1 3-1 10-1!, Book::sort_file(%w!1-1 10-1 3-1!))
    assert_equal(%w!2-1 2-2 11-1!, Book::sort_file(%w!11-1 2-2 2-1!))
    assert_equal(%w!00-1 omake1 omake2!, Book::sort_file(%w!omake2 omake1 00-1!))

    assert_equal(%w!1-1.jpg 2-1.jpg 2-2.jpg!, Book::sort_file(%w!2-2.jpg 1-1.jpg 2-1.jpg!))
    assert_equal(%w!イラスト(1).jpg イラスト(2).jpg!, Book::sort_file(%w!イラスト(2).jpg イラスト(1).jpg!))
  end
end
