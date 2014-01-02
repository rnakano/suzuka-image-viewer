require_relative './config'

task :default => [:test]

task :test do
  sh "bundle exec ruby test/driver.rb"
end

task :stop do
  if File.exists?("rack.pid")
    pid = File.open("rack.pid"){|f| f.read}.to_i
    Process.kill(:INT, pid)
    sleep 1 # FIXME
  end
end

task :update do
  sh "git pull"
  sh "bundle install"
end

task :start do
  sh "bundle exec rackup -s thin -o #{CONFIG['SERVER_HOST']} -p #{CONFIG['SERVER_PORT']} -E production -D -P rack.pid"
end

task :upgrade => [:stop, :update, :start]

