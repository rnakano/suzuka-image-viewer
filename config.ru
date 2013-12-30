require "./app"

use Rack::Auth::Basic do |user, pass|
  CONFIG["user"] == user && CONFIG["pass"] == pass
end

run Sinatra::Application.new