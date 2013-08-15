require 'spec_helper'

describe "UserPages" do

  subject {page}

  describe "Profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "Signup Page" do
    before { visit signup_path }
    let(:submit) { "Create my account" }

    it { should have_content('Signup')}
    it { should have_title( full_title('Signup'))}

    describe "with invalid data" do
      it "should not create a user" do
        # Expect block calls User.count() before and after click_button
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with partial invalid data" do
      before do
        fill_in "Name", with: "Jean-luc Picard"
        fill_in "Email", with: "jp@starfleet.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      
      describe "and with invalid email should show error message" do
        before do
          fill_in "Email", with: "bad.email.@address..com"
          click_button submit
        end
        it { should have_content("Email is invalid") }
      end

      describe "and with invalid password should show error message" do
        before do
          fill_in "Password", with: "a"
          fill_in "Confirmation", with: "a"
          click_button submit
        end
        it { should have_content("Password is too short") }
      end

      describe "and with a blank name should show error message" do
        before do
          fill_in "Name", with: ""
          click_button submit
        end
        it { should have_content("Name can't be blank") }
      end

      describe "and with unmatching password should show error message" do
        before do
          fill_in "Confirmation", with: "abc12345"
          click_button submit
        end
        it { should have_content("Password confirmation doesn't match") }
      end
    end
  

    describe "with valid data" do
      let(:user_email) { "example@rubyonrailstutorial.org" }
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: user_email
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      it "should create a user" do
        expect { click_button submit}.to change(User, :count).by(1)
      end
      
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: user_email) }
        it { should have_link('Sign out', href: signout_path)}
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end

    end


  end
end
