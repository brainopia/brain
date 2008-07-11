=begin rdoc
  Defines Brain module.
=end

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'mathn'

=begin rdoc
  Contains neural network classes: Brain::Hopfield, Brain::Kohonen and Brain::Perceptron.
  
  Classes are autoloaded with the first invoking.
=end

module Brain
  autoload 'Hopfield', 'brain/hopfield'
end