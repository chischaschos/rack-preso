module Rack
  class Upcase
    def initialize app
      @app = app
    end
   
    def call env
      puts 'upcase'
      p @app
      puts
      status, headers, body = @app.call env
      [status, headers, [body.first.upcase]]
    end
  end
end

use Rack::Upcase
use Rack::ContentLength

app = lambda { |env| [200, { 'Content-Type' => 'text/html' }, 'Hello World'] }
run app
