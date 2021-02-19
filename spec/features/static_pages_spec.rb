require 'rails_helper'

RSpec.describe "Static Pages", type: :feature do

  let(:base_title) {"Surfriends"}
  
  describe "Home Page" do
    
    it "should have the content 'Surfriends'" do
      visit root_path
      expect(page).to have_content('Contact')
    end

    it "should have the title 'Home'" do
      visit root_path
      expect(page).to have_title("Home - #{base_title}")
    end
  end

  describe "About Page" do
    it "should have the content 'About'" do
      visit about_path
      expect(page).to have_content("About")
    end

    it "should have the title 'About'" do
      visit about_path
      expect(page).to have_title("About - #{base_title}")
    end
  end
end
  