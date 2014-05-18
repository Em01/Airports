require './lib/plane'

describe 'Plane' do

  context 'At initialization' do 

    it 'is flying' do 
      expect(Plane.new).to be_flying
    end

    it 'has a name' do
       expect(Plane.new).to respond_to(:name)
      # expect(Plane.new.name).to eq("Some Name")
      plane = Plane.new("Boeing")
      expect(plane.name).to eq "Boeing"
    end 

  end

  context 'landing' do
    context 'it should' do 

    it 'can land' do
      expect(Plane.new).to respond_to(:land!)  
    end

    it 'is not flying after landing' do
      boeing = Plane.new("Boeing")
      expect(boeing).to be_flying
      boeing.land!
      expect(boeing).not_to be_flying
    end
end
  end

  context 'taking off' do
    
    it 'can take off' do 
      expect(Plane.new).to respond_to(:takeoff!)
    end

    it 'is flying after takeoff' do 
      boeing = Plane.new("Boeing")
      boeing.land!
      expect(boeing).not_to be_flying
      boeing.takeoff!
      expect(boeing).to be_flying
    end
  end

end

