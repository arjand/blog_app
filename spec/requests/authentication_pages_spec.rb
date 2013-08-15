require 'spec_helper'

describe "Authentication" do
 
 	subject { page }

 	describe "Signin page" do
 		before { visit signin_path }
 		let(:login) { "Sign in" }
 		let(:user) { FactoryGirl.create(:user) }

 		it { should have_content("Signin") }
 		it { should have_title("Signin") }
 		
 			
		describe "with invalid email address" do
			before do
				fill_in "Email", with: "jp@starfleet.com"
      	fill_in "Password", with: "pAssword"
      	click_button login
			end
			
			it { should have_selector('div.alert.alert-error', text: 'Invalid') }

			describe "after visiting another page" do
			  before { click_link "Home" }
			  it { should_not have_selector('div.alert.alert-error') }
			end
		end

		describe "with invalid password" do
			before do 	 				
				fill_in "Email", with: "arj@test.com"
				fill_in "Password", with: "password"
				click_button login
			end
			it { should have_selector('div.alert.alert-error', text: 'Invalid') }
		end

		describe "with valid username and pass" do
			before do 
				fill_in "Email", with: user.email.upcase
				fill_in "Password", with: user.password
				click_button login
			end
			it { should have_title(user.name) }
			it { should have_link('Profile', href: user_path(user)) }
			it { should have_link('Sign out', href: signout_path) }
			it { should_not have_link('Sign in', href: signin_path) }

			describe "followed by a signout" do
				before do 
					click_link('Sign out')
				end
				it { should have_link('Sign in')}
			end
		end 		
 	end

 	describe "Signout page" do
 		pending
 	end

end
