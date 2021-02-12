require 'rails_helper'

RSpec.describe Post, type: :model do
  
  let(:user) { FactoryBot.create(:user) }
  before do
    @post = user.posts.build(content: "surf surf surf")
  end

  subject { @post }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should be_valid }
  

  describe "when user_id is not present" do
    before { @post.user_id = nil }
    it { should_not be_valid }
  end
end
