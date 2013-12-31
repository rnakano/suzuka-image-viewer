require "./app"

if ENV['RACK_ENV'] == "production"
  use Rack::Auth::Basic do |user, pass|
    CONFIG["user"] == user && CONFIG["pass"] == pass
  end
end

run Sinatra::Application.new