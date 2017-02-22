module Presenters
  class Presenter
    attr_reader :account

    def initialize(account, options = {})
      @account = account
      @source = options[:source]
    end

    def present(resource_or_resources)
      if is_array?(resource_or_resources)
        resource_or_resources.map{|resource| presented_json(resource) }
      else
        presented_json(resource_or_resources)
      end
    end

    private

    def is_array?(resource)
      resource.is_a?(ActiveRecord::Associations::CollectionProxy) || resource.is_a?(Array)
    end
  end
end
