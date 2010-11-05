module Rack
  class Reverse
    def initialize app
      @app = app
    end
   
    def call env
      puts 'reverse'
      p @app
      puts
      status, headers, body = @app.call env
      [status, headers, [body.first.reverse]]
    end
  end
end

use Rack::Reverse
use Rack::ContentLength

app = lambda { |env| [200, { 'Content-Type' => 'text/html' }, 'Hello World'] }
run app
