!SLIDE bullets incremental
# Why do we care? #
## Supported web servers ##
* Mongrel, EventedMongrel, SwiftipliedMongrel
* WEBrick, FCGI, CGI, SCGI, LiteSpeed
* Thin


!SLIDE bullets incremental
## These web servers include handlers in their distributions ##
* Ebb, Fuzed, Glassfish v3
* Phusion Passenger (which is mod_rack for Apache and for nginx)
* Rainbows!, Unicorn, Zbatery


!SLIDE bullets incremental
## Any valid Rack app will run the same on all these handlers, without changing anything ##


!SLIDE bullets incremental
# Supported web frameworks #
* Camping, Coset, Halcyon, Mack
* Maveric, Merb, Racktools::SimpleApplication
* Ramaze, Rum, Sinatra, Sin
* Vintage, Waves
* Wee,  … and many others.


!SLIDE bullets incremental
# Of course *Ruby on Rails* #
* Rails has adopted the *Rack philosophy* throughout the framework
* A Rails application is actually *a collection of Rack and Rails middleware components* that all work together to form the completed whole


!SLIDE commandline incremental small
# Listing the rails middleware stack #
    ...(master) $ rake middleware
    (in /home/chischaschos/Projects/salary-manager)
    use ActionDispatch::Static
    use Rack::Lock
    use ActiveSupport::Cache::Strategy::LocalCache
    use Rack::Runtime
    use Rails::Rack::Logger
    use ActionDispatch::ShowExceptions
    use ActionDispatch::RemoteIp
    use Rack::Sendfile
    use ActionDispatch::Callbacks
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    use ActiveRecord::QueryCache
    use ActionDispatch::Cookies
    use ActionDispatch::Session::CookieStore
    use ActionDispatch::Flash
    use ActionDispatch::ParamsParser
    use Rack::MethodOverride
    use ActionDispatch::Head
    use ActionDispatch::BestStandardsSupport
    use Warden::Manager
    use Sass::Plugin::Rack
    run SalaryManager::Application.routes


!SLIDE bullets incremental
# Things to note #
* The Rack *application being run* with the *run* directive *at the end* of the list of middlewares is the *Rails application's routes*


!SLIDE bullets incremental
# Rails controllers are rack compliant #
## A controller declaration ##
    @@@ ruby
    class HomeController < ApplicationController
      def index
        render :text => "I'm your home controller's body"
      end 
    end

!SLIDE commandline incremental
## Rails console testing (had to shorten the output) ##
    ruby-1.8.7-p302 > ...$ rails console
    Loading development environment (Rails 3.0.0)
    ruby-1.8.7-p302 > app = RailsRackApp::Application.routes
    ruby-1.8.7-p302 > app.class
     => ActionDispatch::Routing::RouteSet 
    ruby-1.8.7-p302 > env = {'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/home/index', 'rack.input' => StringIO.new}
     => {"PATH_INFO"=>"/home/index", "REQUEST_METHOD"=>"GET", "rack.input"=>#<StringIO:0xb6e45f50>} 
    ruby-1.8.7-p302 > status, headers, body = app.call env
     => [200, {"ETag"=>"\"d47cb2eec6f22cb9ff6fbb21cd34b595\"", "Content-Type"=>"text/html; charset=utf-8", "Cache-Control"=>"max-age=0, private, must-revalidate"}, #<ActionDispatch::Response:0xb6d82848 @cookie=[], @blank=false,
    ruby-1.8.7-p302 > body.body
     => "I'm yout home controller's body" 


!SLIDE commandline incremental
## Rack app from a controller declaration ##
    ruby-1.8.7-p302 > app = HomeController.action :index
     => #<Proc:0xb6e26664@/home/chischaschos/.rvm/gems/ruby-1.8.7-p302/gems/actionpack-3.0.0/lib/action_controller/metal.rb:172> 
    ruby-1.8.7-p302 > app.respond_to? 'call'
     => true 
    ruby-1.8.7-p302 > status, headers, body = app.call env
    => [200, {"ETag"=>"\"d47cb2eec6f22cb9ff6fbb21cd34b595\"", "Content-Type"=>"text/html; charset=utf-8", "Cache-Control"=>"max-age=0, private, must-revalidate"}, #<ActionDispatch::Response:0xb6d318a8 @cookie=[], @blank=false,
    ruby-1.8.7-p302 > body.body
     => "I'm yout home controller's body" 


!SLIDE bullets incremental
# There are *two* different ways to install *Rack components* into your Rails *application* #
* 1 - Either *configure* your Rack application as *part of* your *application's middleware stack*
* 2 - Or you can *route URI paths* directly to the *Rack application* *from you application's routes*


!SLIDE bullets incremental small
## 1.1 - Installing a component into your application  ##
### lib/average_time.rb  ###
    @@@ ruby
    class AverageRuntime
      @@requests = 0 
      @@total_runtime = 0.0 
      
      def initialize(app)
        @app = app 
      end 
      
      def call(env)    
        code, headers, body = @app.call(env)
        
        @@requests += 1
        @@total_runtime += headers['X-Runtime'].to_f
        headers['X-AverageRuntime'] = 
          (@@total_runtime / @@requests).to_s

        [code, headers, body]
      end 
    end


!SLIDE  small
## 1.2 - Inserting the middleware ##
### config/application.rb  ###
    @@@ ruby
    require File.expand_path('../boot', __FILE__)
    require 'rails/all'
    Bundler.require(:default, Rails.env) if defined?(Bundler)

    module RailsRackApp
      class Application < Rails::Application

        # starts the important part
        config.autoload_paths += %W(#{config.root}/lib) 
        config.middleware.insert_before Rack::Runtime, 
          "AverageRuntime"
        # end the important part

        config.encoding = "utf-8"
        config.filter_parameters += [:password]
      end 
    end


!SLIDE commandline incremental small
## 1.3 - Verifying middleware is in the stack ##
    ...$ rake middleware
    (in /home/chischaschos/Projects/rack-testing/rails-rack-app)
    use ActionDispatch::Static
    use Rack::Lock
    use AverageRuntime
    use ActiveSupport::Cache::Strategy::LocalCache
    use Rack::Runtime
    use Rails::Rack::Logger
    use ActionDispatch::ShowExceptions
    use ActionDispatch::RemoteIp
    use Rack::Sendfile
    use ActionDispatch::Callbacks
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    use ActiveRecord::QueryCache
    use ActionDispatch::Cookies
    use ActionDispatch::Session::CookieStore
    use ActionDispatch::Flash
    use ActionDispatch::ParamsParser
    use Rack::MethodOverride
    use ActionDispatch::Head
    use ActionDispatch::BestStandardsSupport
    run RailsRackApp::Application.routes


!SLIDE  commandline incremental
## 1.4 Testing our middleware ##
### Look at *X-Averageruntime:* header ###
    ...$ curl -I localhost:3000
    HTTP/1.1 404 Not Found 
    Connection: Keep-Alive
    Content-Type: text/html
    Date: Fri, 05 Nov 2010 16:04:43 GMT
    Server: WEBrick/1.3.1 (Ruby/1.8.7/2010-08-16)
    X-Runtime: 0.312526
    Content-Length: 621
    X-Averageruntime: 0.312526
        

!SLIDE bullets incremental small
## 2.1 - Routing to a rack application  ##
### lib/walking_arrow.rb  ###
    @@@ ruby
    class WalkingArrow

      ARROW = '=>'
      @@spaces = 0

      def call(env)
        @@spaces += 1
        [200, {'Content-Type' => 'text/plain'}, [" "*@@spaces + ARROW + "\n"]]
      end
    end


!SLIDE bullets incremental small
## 2.2 - Add a route  ##
### lib/walking_arrow.rb  ###
    @@@ ruby
    require 'lib/walking_arrow.rb'
    RailsRackApp::Application.routes.draw do
      get 'home/index'
      get 'walkingarrow' => WalkingArrow.new
    end


!SLIDE  commandline incremental
## 2.3 Testing our middleware ##
### Walk!!! ###
    ...$ curl localhost:3000/walkingarrow
     =>
    ...$ curl localhost:3000/walkingarrow
      =>
    ...$ curl localhost:3000/walkingarrow
       =>
    ...$ curl localhost:3000/walkingarrow
        =>
    ...$ curl localhost:3000/walkingarrow
         =>
    ...$ curl localhost:3000/walkingarrow
          =>
