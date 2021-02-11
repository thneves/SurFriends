require 'rails_helper'

RSpec.describe "AuthenticationPages", type: :request do
  describe "Login Page" do
    it "return successful http request" do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end
end
