module Presenters
  class TicketPresenter < Presenter
    def presented_json(resource)
      resource.attributes.merge({
        user: resource.user
      })
    end
  end
end
