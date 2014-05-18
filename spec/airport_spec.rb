require 'airport'
require './lib/plane'

describe "Airport" do 

  let(:airport) { Airport.new("Gatwick") }
  let(:plane) { Plane.new }

  context "at initialization" do 

    it 'has a name' do
    expect(airport.name).to eq("Gatwick")
    #   airport = Airport.new("Gatwick")
    #   expect(airport.name).to eq "Gatwick"
    end 

   it "has a maximum capacity" do 
    @maximum_capacity = 8
    expect(airport.capacity).to eq(@maximum_capacity)
  end

  it "is empty at its first creation" do 
    expect(airport.planes_count).to eq(0)
    end
  end

  context "the control tower" do 

        it "should allow a plane to be released" do 
      expect(airport.planes_count).to eq(0)
      airport.park(plane)
      expect(airport.planes_count).to eq(1)
      airport.discharge(plane)
      expect(airport.planes_count).to eq(0)
    end

    it "should allow a plane to park after it has landed" do 
      expect(airport.planes_count).to eq(0)
      airport.park(plane)
      expect(airport.planes_count).to eq(1)
    end



    it "should change a planes status once it has taken off" do 
      airport.park(plane)
      expect(plane).not_to be_flying
      airport.discharge(plane)
      expect(plane).to be_flying
    end

    context "the advanced control tower" do 

      it "should have an awareness of the planes that are parked in the airport" do 
  plane.land!
  expect { airport.discharge(plane) }.to raise_error(RuntimeError)
end

    it "should turn away a plane from landing if the maximum capacity of the airport has been reached" do 
      airport.capacity.times { airport.park(Plane.new) }
      expect { airport.park(Plane.new("Boeing")) }.to raise_error(RuntimeError)
end

end
end
    end