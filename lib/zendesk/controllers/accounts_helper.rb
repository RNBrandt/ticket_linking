module Zendesk
  module Controllers
    module AccountsHelper

      protected

      def current_account
        @current_account ||= begin
          subdomain = request.subdomains.first
          if subdomain
            Rails.logger.info("Finding account for: #{subdomain}")
            Account.find_by_slug!(subdomain)
          else
            Account.where(slug: 'default').first_or_create
          end
        end
      end
    end
  end
end
