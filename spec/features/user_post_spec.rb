require 'rails_helper'

RSpec.describe "User Posts", type: :feature do
  
  let(:base_title) { "Surfriends" }

  subject { page }

  describe "profile page" do
    
    let(:user) { FactoryBot.create(:user) }
    let!(:m1) { FactoryBot.create(:post, user: user, content:"Skateboard is also cool") }
    let!(:m2) { FactoryBot.create(:post, user: user, content:"Skateboard is also good") }

    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title("#{user.name} - #{base_title}") }

    describe "posts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.posts.count) }
    end

  end

end