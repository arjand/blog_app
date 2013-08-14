require 'spec_helper'

describe UsersHelper do
	let(:user) { FactoryGirl.create(:user) } 
	describe "gravatar_for" do
		it "should have a default size of 50" do
			expect( gravatar_for(user)).to match(/[&?]s=50/)
		end

		it "should support specifying a size " do
			expect( gravatar_for(user, size:20)).to match(/[&?]s=20/)
		end
	end	
end