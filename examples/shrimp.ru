# shrimp.rb
module Rack
  class Shrimp
    SHRIMP_STRING = %{
            |///           
   .*----___//     <-- it was supposed to be a walking shrimp...
  <----/|/|/|                                                   
  }                                          

    def initialize(app)
      @app = app       
    end                

    def call(env)
      puts SHRIMP_STRING
      @app.call(env)    
    end                 
  end                   
end

require 'rack'
require 'rack/lobster'

use Rack::Shrimp            
run Rack::Lobster.new 


