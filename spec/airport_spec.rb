require 'airport'
require './lib/plane'

describe "Airport" do 

  let(:airport) { Airport.new("Gatwick") }
  let(:plane) { Plane.new }

    context "at initialization" do 

      it "has a name" do
       expect(airport.name).to eq("Gatwick")
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

      before do 
       airport.stub(:weather_stormy?).and_return(false)
      end

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
       before do 
       airport.stub(:weather_stormy?).and_return(false)
      end

      it "should have an awareness of the planes that are parked in the airport" do 
       plane.land!
       expect { airport.discharge(plane) }.to raise_error(RuntimeError)
      end

      it "should turn away a plane from landing if the maximum capacity of the airport has been reached" do 
       airport.capacity.times { airport.park(Plane.new) }
       expect { airport.park(Plane.new("Boeing")) }.to raise_error(RuntimeError)
      end
    end

    context "weather problems" do 

      before do 
       airport.park(plane)
       airport.stub(:weather_stormy?).and_return(true)
      end

      it 'should know if the weather is sunny or stormy' do 
       expect(airport.weather_stormy?).to be(true)
      end

      it 'will not allow a plane to land if it is not sunny' do 
       expect{airport.park(plane)}.to raise_error(RuntimeError)
      end

      it 'will not allow planes to take off if it is stormy?' do
        expect{airport.discharge(plane)}.to raise_error(RuntimeError)
      end
    end

    context 'the grand finale' do 

      before do 
        airport.stub(:weather_stormy?).and_return(false)
      end

      it 'when there are eight planes all planes can land and park' do 
        8.times{airport.park(Plane.new)}
        expect(airport.planes_count).to eq 8
      end

      it 'when an airport is full then release all planes' do 
        airport.grand_finale_discharge!
        expect(airport.planes_count).to eq 0
      end
    end
  end
end

    