require 'spec_helper'

describe "StaticPages" do

  let(:base_title) { "Blog App" }

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content('Blog App') }  
    it { should have_title( full_title('') ) }
    it { should_not have_title('| Home') }
  end
  # describe "Home page" do
  #   before { visit root_path }  # visit the root path before each example
  #   it "should have the content 'Blog App'" do      
  #     expect(page).to have_content('Blog App')      
  #   end
  #   it "should have the right title" do
  #   	expect(page).to have_title("#{base_title} ")
  #   end
  #   it "should not have a custom page title" do
  #     expect(page).not_to have_title("#{base_title} | Home")
  #   end    
  # end

  describe "Help page" do
    before { visit help_path }

  	it { should have_content('Help') }  
    it { should have_title( full_title('Help') ) }  
  end

  describe "About page" do
    before { visit about_path }
    
    it { should have_content('About') }  
    it { should have_title( full_title('About') ) }  
  end

  describe "Contact page" do
    before { visit contact_path }
    
    it { should have_content('Contact') }  
    it { should have_title( full_title('Contact') ) }  
  end



end
