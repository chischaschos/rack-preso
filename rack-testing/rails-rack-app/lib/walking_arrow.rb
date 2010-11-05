class WalkingArrow
  
  ARROW = '=>'  
  @@spaces = 0
  
  def call(env)
    @@spaces += 1
    [200, {'Content-Type' => 'text/plain'}, [" "*@@spaces + ARROW + "\n"]]
  end
end
