module Zendesk
  module Controllers
    module AuthenticationHelper
      def require_access
        return if current_account.present?
        render text: 'Unable to access resource', status: 401
      end
    end
  end
end
