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


!SLIDE commandline incremental
# Things to note #
* The Rack *application being run* with the *run* directive *at the end* of the list of middlewares is the *Rails application's routes*


!SLIDE bullets incremental
# There are *two* different ways to install *Rack components* into your Rails *application* #
* Either *configure* your Rack application as *part of* your *application's middleware stack*
* You can *route URI paths* directly to the *Rack application* *from you application's routes*



