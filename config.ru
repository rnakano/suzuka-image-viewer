require "./app"
require "logger"

if ENV['RACK_ENV'] == "production"
  file = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
  file.sync = true
  use Rack::CommonLogger, file
end

run Sinatra::Application.new