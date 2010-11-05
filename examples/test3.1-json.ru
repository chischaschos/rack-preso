require 'json'

module Rack
  class JSON
    def initialize app
      @app = app
    end
   
    def call env
      @status, @headers, @body = @app.call env
      @body = ::JSON.generate @body if json_response?
      p @headers
      [@status, @headers, @body]
    end
   
    def json_response?
      @headers['Content-Type'] == 'application/json'
    end
  end
end

use Rack::ContentLength
use Rack::JSON

app = lambda { |env| [200, { 'Content-Type' => 'application/json' }, { :some => 'json', :stuff => ['here'] } ] }
run app
