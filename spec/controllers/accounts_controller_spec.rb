require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  let(:account){ Account.create!(slug: 'default') }

  describe "with an existing account" do
    describe "GET #show" do
      it "responds successfully with an HTTP 200 status code" do
        get :show, id: account
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "loads the requested ticket into @ticket" do
        get :show, id: account
        expect(assigns(:account)).to match(account)
      end
    end
  end
end
