=begin rdoc
  Defines Brain::Hopfield::Sample class.
=end

=begin rdoc
  Uses a given Hopfield object for a successive accosiation with a given sample.

  When there is too much noise in the initial sample, it can associate it with an inverse version of a learning sample. Example:
 
    net = Brain::Hopfield[[1, 1, 1, 1]]
    sample = net.associate [1, -1, -1, -1]
    sample.run until sample.associated?
    sample.current # => [-1, -1, -1, -1]
 
  Initial sample [1, -1, -1, -1] containes too much noise to be comparable with [1, 1, 1, 1]. So sample is associated with the inverse version of [1, 1, 1, 1] which equals [-1, -1, -1, -1].
=end
class Brain::Hopfield::Sample
    
  # A sample must have same dimension as a Hopfield object.
  def initialize(net, sample)
    @net, @initial, @indexes = net, sample, []
    @current, @iterations, @associated = initial, 0, false
    
    sample_must_have_same_dimension_as_net!
    @associated = true if known_sample?
  end
  
  # Returns true if the current sample is accosiated.
  def associated?
    @associated
  end
  
  # Used to update a state of the current sample in a random order. A number of updated positions is controlled with a given parameter.  
  def run(number = 1)
    number.times do
      break if associated?
      update_next_neuron
      @associated = true if minimal_energy? or known_sample?
    end
    current
  end
  
  # Measure of closerness to learning samples. The least energy state corresponds to an association with a learning sample.
  def energy
    (Matrix.row_vector(current) * net.weights).row(0).inner_product current
  end
  
  # A corresponding Hopfield object.
  def net
    @net
  end
  
  # Initial state of sample.
  def initial
    @initial
  end
  
  # Current state of sample.
  def current
    @current
  end
  
  # Number of itererations.
  def iterations
    @iterations
  end
  
  protected
    
  def sample_must_have_same_dimension_as_net!
    raise ArgumentError unless current.size == net.dimension
  end
  
  def known_sample?
    net.learning_samples.any? {|sample| sample == current }
  end
  
  def minimal_energy?
    @energy_changed = true unless @previous_energy == energy
    if @indexes.empty?
      @energy_changed ? (@energy_changed = false) : true
    end
  end
  
  def activation_argument(neuron_index)
    net.weights.row(neuron_index).inner_product current
  end
  
  def activation_function(neuron_index)
    activation = activation_argument neuron_index
    return  1 if activation > 0
    return -1 if activation < 0
    current[neuron_index]
  end
  
  def next_neuron
    @indexes = Array.new(net.dimension) {|i| i } if @indexes.empty?
    @indexes.delete_at rand(@indexes.size)
  end
  
  def update_next_neuron
    @previous_energy = energy
    neuron_index = next_neuron
    current[neuron_index] = activation_function neuron_index
    @iterations += 1
  end
end