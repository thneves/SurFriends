require 'rails_helper'

RSpec.describe User, type: :model do
  
    
  before do
    @user = User.new(name: "Example User", email:"user@example.com",
                     password:"foobar", password_confirmation:"foobar")
  end 

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should be_valid }
  it { should respond_to(:authenticate) } #if the given password matches the user's password it should return the user
  it { should respond_to(:posts) }
  it { should respond_to(:feed) }
  it { should respond_to(:relationships) }

# name tests

  describe "when name is not present" do
    before { @user.name = " "}
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 26 }
    it { should_not be_valid }
  end

  # email tests

  describe "when email is not present" do
    before { @user.email = " "}
    it { should_not be_valid }
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "email address with mixed case" do
    let(:mixed_email) { "Foo@ExAMpLe.CoM"}

    it "should be saved as lower-case" do
      @user.email = mixed_email
      @user.save
      expect(@user.reload.email).to eq mixed_email.downcase
    end
  end

  # password tests

  describe "when password is not present" do
    before do
      @user = User.new(name:"Zidane", email:"zizou@example.com", password:" ", password_confirmation:" ")
    end
        
    it { should_not be_valid }
  end

  describe "password is too short" do
    before { @user.password = @user.password_confirmation = "a" * 4 }
    it { should be_invalid}
  end

  describe "password doesn't match" do
    before { @user.password_confirmation = "not_matching" }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }
  

    describe "valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "invalid password" do
      let(:user_invalid_pass) { found_user.authenticate("invalid") }

      it { should_not eq user_invalid_pass }
      specify { expect(user_invalid_pass).to be_falsey }
    end
  end

  # posts associations

  describe "posts associations" do
    before { @user.save }
    let!(:older_post) do
      FactoryBot.create(:post, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_post) do
      FactoryBot.create(:post, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right post in the right order" do
      expect(@user.posts.to_a).to eq [newer_post, older_post]
    end

    it "should destroy associated posts when user deleted" do
      posts = @user.posts.to_a
      @user.destroy
      expect(posts).not_to be_empty
      posts.each do |post|
        expect(Post.where(id: post.id)).to be_empty
      end
    end
  end  
end