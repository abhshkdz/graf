require_relative '../../test_helper'
 
describe Graf do
 
  it "must be defined" do
    Graf::VERSION.wont_be_nil
  end
 
end