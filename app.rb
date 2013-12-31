# -*- coding: utf-8 -*-
require 'sinatra'
require 'yaml'
require 'json'
require 'rmagick'
require 'tempfile'

CONFIG = YAML.load_file(Dir.pwd + "/config.yaml")

def file_list dir_name
  begin
    Dir.entries(dir_name)
      .reject{|file_name| file_name =~ /^\./}
  rescue
    []
  end
end

class Image
  THUMBNAIL_WIDTH = 600
  TEMPFILE_BASENAME = "image"

  def initialize path
    @path = path
  end

  def thumbnail_binary
    image = Magick::Image.read(@path).first
    scale = THUMBNAIL_WIDTH.to_f / image.columns
    thumbnail_image = image.resize(scale)
    tempfile = Tempfile.new(TEMPFILE_BASENAME)
    thumbnail_image.write(tempfile.path)
    tempfile.read
  end
end

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

get '/' do
  @books = Book.all;
  erb :index
end

def validate_name str
  str =~ /[a-zA-Z_\-]+/
end

get '/viewer/:name' do
  if validate_name(params[:name])
    @book = Book.read_dir(params[:name])
    erb :viewer
  else
    @error_message = "そんな名前のディレクトリしりません＞＜"
    erb :error
  end
end

get '/thumbnail/:name/:id' do
  if validate_name(params[:name]) and validate_name(params[:id])
    path = [ CONFIG["DATA_DIR"], params[:name], params[:id] ].join("/")
    cache_control :public
    Image.new(path).thumbnail_binary
  else
    @error_message = "そんな画像ありません＞＜"
    erb :error
  end
end
