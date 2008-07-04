class Brain::Hopfield
  require 'brain/hopfield/sample'
  
  attr_reader :learning_samples, :arity, :weights
  
  def self.[](*learning_samples)
    new learning_samples
  end
  
  def initialize(learning_samples)
    @learning_samples = learning_samples
    learning_samples_must_be_not_empty!
    
    @arity = @learning_samples.first.size
    learning_samples_must_have_same_arity!
    
    calculate_weight_matrix
  end
  
  def associate(sample)
    Sample.new self, sample
  end
  
  protected
  
  def learning_samples_must_be_not_empty!
    raise ArgumentError if learning_samples.empty?
  end
  
  def learning_samples_must_have_same_arity!
    raise ArgumentError unless learning_samples.all? {|sample| sample.size == arity }
  end
  
  def calculate_weight_matrix
    @weights = Matrix.zero(arity)
    
    learning_samples.each do |sample|
      vector = Matrix.row_vector sample
      @weights += vector.transpose * vector
    end
    
    @weights = Matrix[*@weights.to_a.each_with_index {|row, i| row[i] = 0 }]
  end
end