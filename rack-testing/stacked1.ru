module MyModule
  class Upcase
    def initialize app
      @app = app
    end
   
    def call env
      p 'upcase'
      status, headers, body = @app.call env
      [status, headers, [body.first.upcase]]
    end
  end

  class Reverse
    def initialize app
      @app = app
    end
   
    def call env
      p 'reverse'
      status, headers, body = @app.call env
      [status, headers, [body.first.reverse]]
    end
  end
end

use MyModule::Upcase
use MyModule::Reverse
use Rack::ContentLength

app = lambda { |env| [200, { 'Content-Type' => 'text/html' }, 'Hello World'] }
run app
