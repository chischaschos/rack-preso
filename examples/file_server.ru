require 'rack/file'
run Rack::File.new Dir.pwd
