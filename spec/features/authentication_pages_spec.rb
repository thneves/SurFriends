require 'rails_helper'

RSpec.describe "Login and Authentication", type: :feature do
  
  let(:base_title) { "Surfriends" }
  subject { page }

  describe "Log In page" do
    
    before { visit login_path }

    it { should have_content('Log In') }
    it { should have_title( "Log In - #{base_title}") }
  end

  describe "Log In" do
    before { visit login_path }

    describe "invalid info" do
      before { click_button "Log In" }

      it { should have_title("Log In - #{base_title}") }
      it { should have_selector('div.alert.alert-error') }

      describe "after changing page" do
        before { click_link "Home" }
        it {should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "valid info" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email", with: user.email.upcase # testing downcasing emails
        fill_in "Password", with: user.password
        click_button "Log In"
      end

      it { should have_title(user.name) }
      it { should have_link('Profile'), href: user_path(user) }
      it { should have_link('Log Out'), href: logout_path }
      it { should_not have_link('Log In'), href: login_path }
    end
  end
end