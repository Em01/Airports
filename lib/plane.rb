class Plane

  def initialize(name = "Some Name")
    @name   = name
    @flying = true
  end

  def flying?
    @flying
  end

  attr_reader :name

  def land!
    @flying = false
    
  end

  def takeoff!
    @flying = true

  end

end