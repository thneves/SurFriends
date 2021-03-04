require 'rails_helper'

RSpec.describe 'UserPages', type: :request do
  describe 'Register page' do
    it 'should return successful http request for Sign Up page' do
      get register_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'Login page' do
    it 'should return successful http request for Login page' do
      get login_path
      expect(response).to have_http_status(200)
    end
  end
end
