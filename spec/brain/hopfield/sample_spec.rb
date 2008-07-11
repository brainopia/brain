require File.dirname(__FILE__) + '/../../spec_helper'

describe Brain::Hopfield::Sample do
  it "should be initialized with a Hopfield net and a sample" do    
    lambda { Hopfield::Sample.new Hopfield[ [1, 1, 1] ], [-1, 1, -1] }.
        should_not raise_error(ArgumentError)
  end

  it "should raise error if the sample has a different arity then the net" do
    lambda { Hopfield::Sample.new Hopfield[ [1, 1, 1] ], [-1, 1, -1, 1] }.
        should raise_error(ArgumentError)    
  end
  
  it "should check if the sample belongs to learning samples" do
    sample = Hopfield::Sample.new(Hopfield[ [1, 1, 1] ], [1, 1, 1])
    sample.associated?.should == true
  end

  describe '(after initialization)' do
    before(:each) do
      @learned_sample = [1, -1, 1, -1, 1, -1, 1, -1, 1, -1]
      @tested_sample = [-1, -1, -1, -1, -1, -1, 1, 1, 1, -1]
      
      @net = Hopfield[ @learned_sample ]
      @sample = Hopfield::Sample.new @net, @tested_sample
    end
    
    it "should start an iterations count with 0" do
      @sample.iterations.should == 0
    end
    
    it "should return a status of training" do
      @sample.associated?.should == false
    end
    
    it "should return a current associated sample" do
      @sample.current.should == @tested_sample
    end
    
    it "should return an initial sample" do
      @sample.initial.should == @tested_sample
    end
    
    it "should be ran a given number of times" do
      @sample.run(50).should == @learned_sample
    end
    
    it "should increment iterations after an every run" do
      @sample.stub!(:associated?).and_return(false)
      3.times { @sample.run(3) }
      @sample.iterations.should == 9
    end
    
    it "should stop incrementing iterations after it's associated" do
      @sample.stub!(:associated?).and_return(false)
      @sample.run(4)
      @sample.stub!(:associated?).and_return(true)
      @sample.run(4)
      @sample.iterations.should == 4
    end
    
    it "should be ran by default one time" do
      @sample.run
      @sample.iterations.should == 1
    end
    
    it "should return an using net" do
      @sample.net.should == @net
    end
    
    it "shouldn't increase energy" do
      previous_energy = @sample.energy
      until @sample.associated?
        @sample.run
        previous_energy.should_not > @sample.energy
        previous_energy = @sample.energy
      end
    end
    
    it "should return an inverse version of the learning sample if there is too much noise in the initial sample" do
      net = Brain::Hopfield[[1, 1, 1, 1]]
      sample = net.associate [1, -1, -1, -1]
      sample.run until sample.associated?
      sample.current.should == [-1, -1, -1, -1]
    end    
  end
end