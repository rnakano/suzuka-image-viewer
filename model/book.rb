require 'json'

class Book
  def initialize args
    @images = args[:images]
    @name = args[:name]
  end

  def viewer_link
    "/viewer/" + @name 
  end

  def thumbnail
    "/thumbnail/" + @name + "/" + @images.first
  end

  def empty?
    @images.empty?
  end

  def image_file_list_json
    JSON.dump(@images.map{|i| "/img/" + @name + "/" + i})
  end

  def self.all
    file_list(CONFIG["DATA_DIR"]).map{|dir_name|
      self.read_dir(dir_name)
    }
  end

  def self.read_dir dir_name
    images = file_list(CONFIG["DATA_DIR"] + "/" + dir_name).select{|file_name|
      file_name =~ /(jpg|jpeg|png|gif)$/i
    }
    self.new(:images => images, :name => dir_name)
  end

  attr_reader :name
end
