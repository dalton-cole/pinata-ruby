require 'pinata'

describe Pinata::Pin do
  it "pin pins" do
    expect(Pinata::Pin.pin_file("pin")).to eql("https://api.pinata.cloud/pinning/pinFileToIPFS")
  end

  it "unpin unpins" do
    expect(Pinata::Pin.remove_pin("unpin")).to eql("https://api.pinata.cloud/pinning/removePinFromIPFS")
  end
end
