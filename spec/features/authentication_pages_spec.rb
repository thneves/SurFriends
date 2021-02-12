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
      let(:user) { FactoryBot.create(:user) }
      before do
        fill_in "Email", with: user.email.upcase # testing downcasing emails
        fill_in "Password", with: user.password
        click_button "Log In"
      end

      it { should have_title(user.name) }
      it { should have_link('Profile'), href: user_path(user) }
      it { should have_link('Log Out'), href: logout_path }
      it { should have_link('Surfers'), href: users_path }
      it { should have_link('Settings', href: edit_user_path(user))}
      it { should_not have_link('Log In'), href: login_path }
    end
  end

  describe "Authorization" do
    describe "for non-signed-in users" do
      let(:user) { FactoryBot.create(:user) }

      describe "in the Users controller" do
        
        describe "visit the editing page" do
          before { visit edit_user_path(user) }
          it { should have_title("Log In - #{base_title}") }
        end
      end

      describe "visiting user index" do
        before { visit users_path }
        it { should have_title("Log In - #{base_title}") }
      end
    end 
  end

  describe "Index" do
    let(:user) { FactoryBot.create(:user) }
    before do
      visit login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log In"
      FactoryBot.create(:user, name: "Bob", email: "bob@example.com")
      FactoryBot.create(:user, name: "Ben", email: "ben@example.com")
      visit users_path
    end

    it { should have_title("All Surfers - #{base_title}") }
    it { should have_content("All Surfers") }

    it "should list each user" do
      User.all.each do |user|
        expect(page).to have_selector('li', text: user.name)
      end
    end
  end
end