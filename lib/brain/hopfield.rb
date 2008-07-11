=begin rdoc
  Defines Brain::Hopfield class.
=end

=begin rdoc
  Represents a Hopfield net.
    
    net = Brain::Hopfield[[-1, -1, -1, -1], [1, 1, 1, 1]]
    sample = net.associate [1, 1, -1, 1]
    sample.run until sample.associated?
    sample.current # => [1, 1, 1, 1]
    sample.iterations # => 2
    
  In this example, it can take up to 4 iterations to associate the sample (actual value depends on a random order of updating neurons).
=end
class Brain::Hopfield
  require 'brain/hopfield/sample'
  
  # Shortcut for creation of a new Hopfield object.
  def self.[](*learning_samples)
    new learning_samples
  end
  
  # Learning samples must be not empty and have same dimension.
  def initialize(learning_samples)
    @learning_samples = learning_samples
    learning_samples_must_be_not_empty!
    
    @dimension = @learning_samples.first.size
    learning_samples_must_have_same_dimension!
    
    calculate_weight_matrix
  end
  
  # Returns a Brain::Hopfield::Sample object which can be used for an association of given sample.
  def associate(sample)
    Sample.new self, sample
  end
  
  # Learning samples attribute.
  def learning_samples
    @learning_samples
  end

  # Weights attribute.
  def weights
    @weights
  end
  
  # Dimension attribute.
  def dimension
    @dimension
  end
  
  protected
  
  def learning_samples_must_be_not_empty!
    raise ArgumentError if learning_samples.empty?
  end
  
  def learning_samples_must_have_same_dimension!
    raise ArgumentError unless learning_samples.all? {|sample| sample.size == dimension }
  end
  
  def calculate_weight_matrix
    @weights = Matrix.zero(dimension)
    
    learning_samples.each do |sample|
      vector = Matrix.row_vector sample
      @weights += vector.transpose * vector
    end
    
    @weights = Matrix[*@weights.to_a.each_with_index {|row, i| row[i] = 0 }]
  end
end