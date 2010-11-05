$:.unshift File.expand_path '../forked-repos/rack-validate/lib'

require 'rack-validate'

use Rack::Validate

map '/hello' do
  run lambda { |env| [200, { 'Content-Type' => 'text/html' }, 'Hello World'] }
end
