!SLIDE bullets incremental
## Is this testable? ##
* Use your favorite framework
* It provides *Rack::MockRequest* and *Rack::MockResponse*


!SLIDE bullets incremental
### With [bacon](https://github.com/chneukirchen/bacon/) ###
* > Bacon is a *small RSpec clone* weighing less than *350 LoC* but nevertheless providing all essential features.


!SLIDE bullets incremental smaller
### MockRequest ###
    @@@ ruby
    describe Rack::Static do
      root = File.expand_path(File.dirname(__FILE__))
      OPTIONS = {:urls => ["/cgi"], :root => root}

      @request = 
        Rack::MockRequest.new(
          Rack::Static.new(DummyApp.new, OPTIONS))

      it "serves files" do
        res = @request.get("/cgi/test")
        res.should.be.ok
        res.body.should =~ /ruby/
      end 
    end


!SLIDE bullets incremental smaller
### MockResponse ###
    @@@ ruby
    describe Rack::Chunked do
      before do
        @env = Rack::MockRequest.
          env_for('/', 'HTTP_VERSION' => '1.1', 'REQUEST_METHOD' => 'GET')
      end 

      should 'chunk responses with no Content-Length' do
        app = lambda { |env| [200, {}, ['Hello', ' ', 'World!']] }
        response = Rack::MockResponse.new(
          *Rack::Chunked.new(app).call(@env))
        response.headers.should.not.include 'Content-Length'
        response.headers['Transfer-Encoding'].should.equal 'chunked'
        response.body.should.equal 
          "5\r\nHello\r\n1\r\n \r\n6\r\nWorld!\r\n0\r\n\r\n"
      end 
    end
