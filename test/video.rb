# -*- coding: utf-8 -*-
require 'minitest/unit'
require 'minitest/autorun'
require './config'
require './model/video'
require 'tmpdir'

class TestVideo < MiniTest::Unit::TestCase
  def test_all
    Dir.mktmpdir{|dir|
      File.open("#{dir}/a.mp4", "w").close
      File.open("#{dir}/b.mp4", "w").close
      CONFIG["DATA_VIDEO_DIR"] = dir
      videos = Video.all
      assert_equal ["a.mp4", "b.mp4"], videos.map(&:name)
    }
  end
end
