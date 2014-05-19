require_relative 'weather'
require_relative 'plane'

class Airport

  include Weather

    attr_reader :name, :capacity 

    Maximum_Capacity = 8

    def initialize(name, maximum_capacity=8)
      @name   = name
      @capacity = maximum_capacity
      @planes = []
    end

    def planes_count
      @planes.count 
    end

    def park(plane)
      raise "Sorry! You cannot land due to the weather conditions !" if weather_stormy?
      raise "We are so sorry but the airport is no full, please try landing at a different airport-we apologise for the inconvenience caused" if full?
      plane.land!
      @planes << plane
    end

    def release(plane)
      raise "Sorry, There is no longer a plane parked here!" if !@planes.include?(plane)
      raise "Sorry you cannot fly today, the weather is too bad!" if weather_stormy?
      @planes.delete(plane)
      plane.takeoff!
    end  

    def empty?
      planes_count == 0
    end

    def full?
      @planes.count == @capacity
    end

    def grand_finale_release!
      while full?
      release @planes
    end
  
  end

end

