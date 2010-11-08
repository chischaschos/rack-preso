require 'rack/file'

class MyHaml
  require 'haml'
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    if env['PATH_INFO'] =~ /\.haml$/
      body = parse_haml(body)
      headers['Content-Length'] = body.length.to_s
      headers['Content-Type'] = 'text/html'
    end
    
    [status, headers, body] 
  end

  private
  def parse_haml(body)
    full_body = traverse_body(body)
    engine = Haml::Engine.new full_body
    engine.render
  end

  def traverse_body(body)
    text = ''
    body.each {|x| text << x}
    text
  end
  
end

use MyHaml
run Rack::File.new(File.expand_path('public'))
