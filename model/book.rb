require 'json'
require_relative '../util'
require_relative '../config'
require_relative './image'

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
    images = @images.map{|i| Image.new(@name, i) }
    path = @images.map{|i| "/img/" + @name + "/" + i }
    sizes = Image.sizes(images)
    JSON.dump(path.zip(sizes).map{|pathi, sizei|
      { :path => pathi, :size => sizei }
    })
  end

  def slot_file_list_json
    JSON.dump(@images.map{|i| "/slot/" + @name + "/" + i})
  end

  def self.all
    file_list(CONFIG["DATA_DIR"])
      .sort_by{|dir_name| File::mtime(CONFIG["DATA_DIR"] + "/" + dir_name) }
      .reverse
      .map{|dir_name| self.read_dir(dir_name)
    }
  end

  def self.read_dir dir_name
    images = file_list(CONFIG["DATA_DIR"] + "/" + dir_name).select{|file_name|
      file_name =~ /(jpg|jpeg|png|gif)$/i
    }
    self.new(:images => sort_file(images), :name => dir_name)
  end

  def self.sort_file file_list
    file_list.sort_by{|i| 
      arr = i.scan(/\d+/)
      arr.empty? ? [ Float::INFINITY ] : arr.map(&:to_i)
    }
  end

  attr_reader :name
end
