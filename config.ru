require "./app"
require "logger"

if ENV['RACK_ENV'] == "production"
  file = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
  file.sync = true
  use Rack::CommonLogger, file
end

# monkey patching for rack daemonize
module Rack
  class Server
    def daemonize_app
      if RUBY_VERSION < "1.9"
        exit if fork
        Process.setsid
        exit if fork
        STDIN.reopen "/dev/null"
        STDOUT.reopen "/dev/null", "a"
        STDERR.reopen "/dev/null", "a"
      else
        Process.daemon(nochdir: true)
      end
    end
  end
end

run Sinatra::Application.new
