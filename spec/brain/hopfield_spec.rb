require File.dirname(__FILE__) + '/../spec_helper'

describe Brain::Hopfield do
  it "should be created with learning samples" do
    lambda { Hopfield.new }.should raise_error(ArgumentError)
    lambda { Hopfield.new [] }.should raise_error(ArgumentError)
    lambda { Hopfield.new [[1, 1], [1, 1]] }.should_not raise_error 
  end
  
  it "learning samples should have a same arity" do
    lambda { Hopfield.new [[-1, -1], [1]] }.should raise_error(ArgumentError)
    lambda { Hopfield.new [[-1, -1], [1, 1]] }.should_not raise_error
  end
  
  it "should have a shortcut [] for creation" do
    Hopfield[[1, 1], [1, 1]].should be_instance_of(Hopfield)
  end
  
  describe '(after initialization)' do
    before(:each) do
      @net = Hopfield[ [-1, 1, -1], [1, -1, 1] ]
    end

    it "should return a weight matrix" do
      @net.weights.should == Matrix[ [ 0, -2,  2],
                                     [-2,  0, -2],
                                     [ 2, -2,  0] ]
    end
    
    it "should return an array of learning samples" do
      @net.learning_samples.should == [ [-1, 1, -1], [1, -1, 1] ]
    end
    
    it "should return an arity" do
      @net.dimension.should == 3
    end
    
    it "should create an object for an association with a given sample" do
      associated_sample = @net.associate([1, 1, 1])
      associated_sample.should be_instance_of(Hopfield::Sample)
    end    
  end
end