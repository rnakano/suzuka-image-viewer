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
  str =~ /[a-zA-Z_\-]+/
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

get '/thumbnail/:name/:id' do
  if validate_name(params[:name]) and validate_name(params[:id])
    path = [ CONFIG["DATA_DIR"], params[:name], params[:id] ].join("/")
    cache_control :public
    Image.new(path).thumbnail_binary
  else
    error_page "そんな画像ありません＞＜"
  end
end
