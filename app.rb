# -*- coding: utf-8 -*-
require 'sinatra'
require_relative './config'
require_relative './model/book'
require_relative './model/image'
require_relative './model/video'

get '/' do
  # get recent books
  @books = Book.all[0...6]
  erb :index
end

get '/all' do
  # older sort
  @books = Book.all.reverse
  erb :all  
end

get '/video' do
  @videos = Video.all
  erb :video_list
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
    cache_control :public, :max_age => 60 * 15
    content_type File::extname(params[:id])[1..-1].downcase
    Image.new(params[:name], params[:id]).send(method)
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

get '/video-thumbnail/:name/:number' do
  video = Video.new(params[:name])
  content_type :jpg
  video.thumbnail_binary params[:number].to_i
end
