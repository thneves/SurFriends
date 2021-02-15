require 'rails_helper'

RSpec.describe 'Post Pages', type: :feature do
  
    subject { page }

    let(:user) { FactoryBot.create(:user) }
    before do
      visit login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log In"
    end

    describe "Post creation" do
      before { visit root_path }
      
      describe "invalid info" do
        
        it "should not create a post" do
          expect { click_button "Post" }.not_to change(Post, :count)
        end

        describe "error messages" do
          before { click_button "Post" }
          it { should have_content('error') }
        end
      end

      describe "valid info" do
        
        before { fill_in "post_content", with: "Surf Surf Surf" }
        it "should create a post" do
          expect { click_button "Post" }.to change(Post, :count).by(1)
        end
      end
    end

    describe "Post destruction" do
      before { FactoryBot.create(:post, user: user) }

      describe "logged in user" do
        before { visit root_path }
        it "should delete a post" do
          expect { click_link 'delete'}.to change(Post, :count).by(-1)
        end
      end
    end
end