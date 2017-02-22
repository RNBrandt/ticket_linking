module Zendesk
  module Controllers
    module PresenterHelper

      private

      %w(ticket account).each do |resource|
        presenter_class = "Presenters::#{resource.camelize}Presenter".constantize
        presenter_name = "#{resource}_presenter"
        define_method(presenter_name) do
          presenter = instance_variable_get :"@#{presenter_name}"
          return presenter if presenter.present?

          presenter = presenter_class.new(current_account, source: self)
          instance_variable_set :"@#{presenter_name}", presenter
        end
      end
    end
  end
end
