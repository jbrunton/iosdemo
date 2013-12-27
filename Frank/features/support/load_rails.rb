current_directory = Dir.pwd
 
ENV["RAILS_ENV"] ||= 'test'
RAILS_ROOT = '/Users/John/git/iosdemo-api' # ENV["RAILS_ROOT"] || File.expand_path("#{File.dirname(File.expand_path(__FILE__))}/../../../../Rails")
ENV["RAILS_ROOT"] = RAILS_ROOT
 
Dir.chdir(RAILS_ROOT)
$LOAD_PATH.unshift File.expand_path("#{RAILS_ROOT}/config")
require "environment"
Dir.chdir(current_directory)
 
require 'factory_girl'
begin
  Factory.find_definitions
rescue
  
end
 
# Before { Mongoid::IdentityMap.clear }
#  
# require 'database_cleaner'
# DatabaseCleaner.orm = "mongoid"
# DatabaseCleaner.strategy = :truncation
# Before { DatabaseCleaner.clean }
# After do
#   FileUtils.rm_rf("#{RAILS_ROOT}/public/events")
#   FileUtils.rm_rf("#{RAILS_ROOT}/tmp/events")
# end
 
# Stop the WEBRick server by looking for it in the process tree.
def stop_webrick
  res = `ps aux | grep [r]uby | grep [s]cript/rails`
  pid = res.split[1]
  return unless pid
  puts "#{$0} STOPPING WEBRick pid=#{pid}"
  Process.kill "KILL", pid.to_i
end
 
# Start WEBRick with the configured rails environment as a daemon (background).
def start_webrick
  cmd = "script/rails server -e test -d"
  puts "#{$0} Starting WEBRick: #{cmd}"
  system cmd
end
 
 
Dir.chdir(RAILS_ROOT)
start_webrick
Dir.chdir(current_directory)
  
at_exit do
  Dir.chdir(RAILS_ROOT)
  stop_webrick
  Dir.chdir(current_directory)
end
