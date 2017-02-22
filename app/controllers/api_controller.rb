class ApiController < ApplicationController
  include Zendesk::Controllers::PresenterHelper

  before_action :require_access

  def index
    render json: {
      accounts: "/api/v1/accounts/#{current_account.slug}.json",
      tickets:  '/api/v1/tickets.json'
    }
  end
end
