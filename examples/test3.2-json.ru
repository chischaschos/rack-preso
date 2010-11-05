require 'json'

module Rack
  class JSON
    def initialize app
      @app = app
    end
   
    def call env
      @status, @headers, @body = @app.call env
      @body = ::JSON.generate @body if accepts_json?
      @headers = {"Content-type" => "application/json"} if accepts_json?
      [@status, @headers, @body]
    end
   
    def accepts_json?
      @headers['Accept'] == 'application/json'
    end
  end
end

use Rack::ContentLength
use Rack::JSON

app = lambda { |env| [200, { 'Content-Type' => 'text/plain' }, "{'some' => 'json', 'stuff' => ['here']}" ] }
run app
