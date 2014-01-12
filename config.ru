require "./app"
require "logger"

if ENV['RACK_ENV'] == "production"
  use Rack::Auth::Basic do |user, pass|
    CONFIG["user"] == user && CONFIG["pass"] == pass
  end

  file = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
  file.sync = true
  use Rack::CommonLogger, file
end

run Sinatra::Application.new