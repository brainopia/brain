class Brain::Hopfield::Sample
  attr_reader :net, :initial, :current, :epochs
  
  def initialize(net, sample)
    @net, @initial, @indexes = net, sample, []
    @current, @epochs, @trained = initial, 0, false
    
    sample_must_have_same_arity_as_net!
    @trained = true if known_sample?
  end
  
  def trained?
    @trained
  end
  
  def run(number = 1)
    number.times do
      break if trained?
      update_next_neuron
      @trained = true if minimal_energy? or known_sample?
    end
    current
  end
  
  def energy
    (Matrix.row_vector(current) * net.weights).row(0).inner_product current
  end
      
  protected
    
  def sample_must_have_same_arity_as_net!
    raise ArgumentError unless current.size == net.arity
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
    @indexes = Array.new(net.arity) {|i| i } if @indexes.empty?
    @indexes.delete_at rand(@indexes.size)
  end
  
  def update_next_neuron
    @previous_energy = energy
    neuron_index = next_neuron
    current[neuron_index] = activation_function neuron_index
    @epochs += 1
  end
end