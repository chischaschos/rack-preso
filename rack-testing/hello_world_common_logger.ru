use Rack::CommonLogger
use Rack::ShowExceptions
use Rack::Lint

map '/hello' do
  run lambda { |env| [200, { 'Content-Type' => 'text/html' }, ['Hello World']] }
end
