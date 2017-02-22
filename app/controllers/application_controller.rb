class ApplicationController < ActionController::Base
  include Zendesk::Controllers::AccountsHelper
  include Zendesk::Controllers::AuthenticationHelper
end
