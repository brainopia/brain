require File.dirname(__FILE__) + '/../../spec_helper'

describe Brain::Hopfield::Sample do
  it "should be initialized with a Hopfield net and a sample" do    
    lambda { Hopfield::Sample.new Hopfield[ [1, 1, 1], [-1, 1, -1] ] }.
        should_not raise_error(ArgumentError)
  end

  it "should raise error if the sample has a different arity then the net" do
    lambda { Hopfield::Sample.new Hopfield[ [1, 1, 1], [-1, 1, -1, 1] ] }.
        should raise_error(ArgumentError)    
  end
  
  describe '(after initialization)' do
    before(:each) do
      sample = Hopfield::Sample.new( Hopfield[ [1, 1, 1, 1] ], [-1, 1, -1, 1] )
    end
    
    it "should start an epochs count with 0" do
      sample.epochs.should == 0
    end
    
    it "should return a status of training" do
      sample.trained?.should == false
    end
    
    it "should check if the sample belongs to learning samples" do
      sample = Hopfield::Sample.new(Hopfield[ [1, 1, 1], [1, 1, 1]])
      sample.trained?.should == true
    end
    
    it "should return a current associated sample" do
      sample.current.should == [-1, 1, -1, 1]
    end
    
    it "should return an initial sample" do
      sample.initial.should == [-1, 1, -1, 1]
    end
    
    it "should be ran a given number of times" do
      sample.run(10).should == [1, 1, 1, 1]
    end
    
    it "should increment epochs after an every run" do
      sample.stub!(:trained?).and_return(false)
      3.times { sample.run(3) }
      sample.epochs.should == 9
    end
    
    it "should stop incrementing epochs after it's trained" do
      sample.stub!(:trained?).and_return(false)
      sample.run(4)
      sample.stub!(:trained?).and_return(true)
      sample.run(4)
      sample.epochs.should == 4
    end
    
    it "should be ran by default one time" do
      sample.run
      sample.epochs.should == 1
    end
  end
end