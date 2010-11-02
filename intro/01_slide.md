!SLIDE 
# Your best friend *Rack* #


!SLIDE bullets incremental
# What is Rack? #

* > Rack provides a minimal interface between webservers supporting Ruby and Ruby frameworks.
* Transparently integrates in your existing rails, sinatra apps
* Helps you easily creates a middleware standalone application stack



!SLIDE bullets incremental
# Where does Rack sit? #
TODO: Put a blocks or sequence diagram showing a request flow and where is Rack positioned among other components


!SLIDE bullets incremental
# What is middleware? #
* > A software that talks to other softwares
TODO: Improve this description


!SLIDE
# Minimum server interfaces you said? #
    @@@ ruby
    app = lambda do |env| 
      [200, { 'Content-Type' => 'text/html' }, 'Hello World']
    end
    run app 


!SLIDE
# Wnat more?  #
    @@@ ruby
    module Rack
      class Reverse
        def initialize app 
          @app = app 
        end 
       
        def call env 
          status, headers, body = @app.call env 
          [status, headers, [body.first.reverse]]
        end 
      end 
    end

    use Rack::Reverse

    app = lambda { |env| [200, { 'Content-Type' => 'text/html' }, 'Hello World'] }
    run app 


!SLIDE bullets incremental
# What happened? #
TODO: I need some sequence diagram to show a request flow


!SLIDE bullets incremental
# The Rack Spec #
TODO: Show what we need to build a rack app
