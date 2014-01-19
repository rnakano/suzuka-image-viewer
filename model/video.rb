require_relative '../util'
require 'tempfile'
require_relative './ffmpeg'
require 'streamio-ffmpeg'

class Video
  include FFMPEGLite
  THUMBNAILS = 30
  TEMPFILE_BASENAME = "vthumbnail"

  def initialize filename
    @filename = filename
    @path = [ CONFIG["DATA_VIDEO_DIR"], filename ].join("/")
  end

  def self.all
    file_list(CONFIG["DATA_VIDEO_DIR"])
      .sort_by{|dir_name| File::mtime(CONFIG["DATA_VIDEO_DIR"] + "/" + dir_name) }
      .map{|dir_name| self.new(dir_name) }
  end

  def name
    File.basename(@path)
  end

  def view_path
    # TODO: fixme
    "video/" + @filename
  end

  def thumbnail_binary thumbnail_number
    movie = FFMPEG::Movie.new(@path)
    target_sec = movie.duration * (thumbnail_number.to_f / THUMBNAILS)
    tempfile = Tempfile.new([TEMPFILE_BASENAME, ".jpg"])
    write_thumbnail(@path, tempfile.path, target_sec.to_i)
    tempfile.read
  end

  def thumbnail_path n
    "/video-thumbnail/#{name}/#{n}"
  end
end
