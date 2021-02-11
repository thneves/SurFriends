require 'rails_helper'

RSpec.describe "Users Pages", type: :feature do
  
  let(:base_title) { "Surfriends" }
  
  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name)}
  end

  describe "register page" do
    before { visit register_path }

    it { should have_content('Register') }
    it { should have_title("Register - #{base_title}")}
  end

  describe "register" do
    before { visit register_path }

    let(:submit) { "Create my account" }

    describe "with invalid info" do
      before do
        fill_in "Name", with: ""
        fill_in "Email", with: ""
        fill_in "Password", with: "foo"
        fill_in "Confirmation", with: "foobar"
      end

      it "should not create a user" do
        expect { click_button submit}.not_to change(User, :count)
      end

      describe "after submission" do
        
        before { click_button submit }

        it { should have_content('error')}
      end
    end

    describe "with valid info" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit}.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }
        
        it { should have_link('Log Out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: "I wanna go surfing")}

      end
    end
  end
end