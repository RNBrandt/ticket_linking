module Presenters
  class AccountPresenter < Presenter
    def presented_json(resource)
      resource.attributes
    end
  end
end
