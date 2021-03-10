require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  describe 'Static Pages' do
    it 'should return http successful for "Home" page' do
      get root_path
      expect(response).to have_http_status(:success)
    end

    it 'should return http successful for "About" page' do
      get about_path
      expect(response).to have_http_status(:success)
    end
  end
end
