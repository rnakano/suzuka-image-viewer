# -*- coding: utf-8 -*-
require 'sinatra'
require_relative './config'
require_relative './model/book'
require_relative './model/image'

def file_list dir_name
  begin
    Dir.entries(dir_name)
      .reject{|file_name| file_name =~ /^\./}
  rescue
    []
  end
end

get '/' do
  @books = Book.all;
  erb :index
end

def validate_name str
  str =~ /[0-9a-zA-Z_\-]+/
end

def error_page error_message
  status 404
  @error_message = error_message
  erb :error
end

get '/viewer/:name' do
  if validate_name(params[:name])
    @book = Book.read_dir(params[:name])
    erb :viewer
  else
    error_page "そんな名前のディレクトリしりません＞＜"
  end
end

def get_image params, method
  if validate_name(params[:name]) and validate_name(params[:id])
    path = [ CONFIG["DATA_DIR"], params[:name], params[:id] ].join("/")
    cache_control :public, :max_age => 60 * 15
    content_type File::extname(params[:id])[1..-1].downcase
    Image.new(path).send(method)
  else
    error_page "そんな画像ありません＞＜"
  end
end

get '/thumbnail/:name/:id' do
  get_image(params, :thumbnail_binary)
end

get '/slot/:name/:id' do
  get_image(params, :slot_binary)
end
