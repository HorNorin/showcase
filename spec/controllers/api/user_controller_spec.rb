require 'rails_helper'

RSpec.describe Api::UserController, type: :controller do

  describe "GET #validate_email" do
    it "returns http success" do
      get :validate_email
      expect(response).to have_http_status(:success)
    end
  end

end
