require_relative '../util'

class Video
  def initialize filename
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
end
