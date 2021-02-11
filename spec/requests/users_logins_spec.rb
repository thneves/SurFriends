require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do
  describe "Login Page" do
    it "should access login page" do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end
end
