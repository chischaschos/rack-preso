module Initializer
  def initialize(app)
    @app = app
  end
  def call(env)
    status, headers, body = @app.call(env)
    body << "\nHi from #{self.class}"
    [status, headers, body]
  end
end

class SayHi
  include Initializer
end

class SayNothing
  include Initializer
end
  
use SayHi
use SayNothing
run lambda { |env| [200, {'Content-Type' => 'text/html'}, ["I'm the endpoint"]] }
