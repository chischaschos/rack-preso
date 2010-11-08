# This module helps converting to string every object that includes it
module Stringfier
  def to_str
    @str
  end
end

# This class receives an object and stores it an instance variable @str
class MyBaseString
  include Stringfier
  def initialize(base_string)
    @str = base_string
  end
end

# This class converts to string the initializer parameter and invokes its
# reverse method
class Reverser
  include Stringfier
  def initialize(base_string)
    @str = base_string.to_str.reverse
  end
end

# This class converts to string the initializer parameter and replaces
# every digit an x
class DigitEliminator 
  include Stringfier
  def initialize(base_string)
    @str = base_string.to_str.gsub(/\d/, 'x')
  end
end

# Here we output the same "Hole 12" message
p "R1: " + MyBaseString.new("Hola 12")

# Here Reverser receives an object that will be converted to string and
# reversed
p "R2: " + Reverser.new(MyBaseString.new("Hola 12"))

# Here DigitEliminator receives and object that will be converted to 
# string and have its digits replaced by x
p "R3: " + DigitEliminator.new(Reverser.new(MyBaseString.new("Hola 12")))


