require 'rails_helper'

RSpec.describe "Authorization", type: :request do
    
  describe "for non-signed-in users to edit" do
  
    let(:user) { FactoryBot.create(:user) }

    describe "in the Users controller" do
        
      describe "submitting to the update action" do
        before { patch user_path(user) }
        specify { expect(response).to redirect_to(login_path)}
      end
    end
  end
end