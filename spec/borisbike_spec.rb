require 'docking_station'

describe DockingStation do
  let(:bike) {double(:bike)}

  it " creates an instance of DockingStation" do
    expect(DockingStation.new).to be_an_instance_of(DockingStation)
  end

  it {is_expected.to respond_to(:release_bike)}

  #  it 'expects DockingStation to get a bike' do
  #    subject.dock(double(:bike).new)
  #    expect(subject.release_bike).to be_an_instance_of(double(:bike))
  # end

  # it 'expects bike to be working' do
  #   subject.dock(double(:bike).new)
  #   expect(subject.release_bike.working?).to eq true
  #  end

  it 'expects docking_station to be initialized with an argument' do
    docking_station = DockingStation.new
    expect(docking_station).to respond_to(:dock).with(1).argument
  end

  it 'expects docking_station to respond to the dock method' do
    docking_station = DockingStation.new
    expect(docking_station).to respond_to(:dock)
  end

  it 'should raise an error when @bike = nil when releasing' do
    if @capacity == nil
      expect{subject.release_bike}.to raise_error("No working bikes available")
    end
  end

  it 'should raise an error when docked bikes = 20 and docking' do
    DockingStation::DEFAULT_CAPACITY.times {subject.dock(double(:bike))}
    expect{  subject.dock(double(:bike))}.to raise_error("full up")
  end

  it "dock accepts argument to #capacity" do
    cap = 15
    ds = DockingStation.new(cap)
    ds.capacity == cap
  end

  it "#capacity is 20 when no agrument passed to new #docking_station" do
    expect(subject.capacity).to eq 20
  end

  it "identify the first available working bike" do
    bike = double(:bike)
    allow(bike).to receive(:working).and_return(false)
    subject.dock(bike)
    bike2 = double(:bike)
    allow(bike2).to receive(:working).and_return(true)
    subject.dock(bike2)
    expect(subject.find_bike).to eq 1
  end

  it "identifies broken bikes and stores them" do
  bike1 = double(:bike)
  allow(bike1).to receive(:working).and_return(true)
  subject.dock(bike1)
  bike2 = double(:bike)
  allow(bike2).to receive(:working).and_return(false)
  subject.dock(bike2)
  subject.broken
  expect(subject.broken_bikes.count).to eq 1

end
end
