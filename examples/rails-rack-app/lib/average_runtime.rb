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
    headers['X-AverageRuntime'] = (@@total_runtime / @@requests).to_s

    [code, headers, body]
  end
end
