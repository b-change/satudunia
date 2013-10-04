class ServiceProviderValidate
  include Mongoid::Document

  field :valid_provider, :type => Boolean
  field :correct_provider, :type => Boolean
  field :valid_prices_provider, :type => Boolean

  referenced_in :user
  referenced_in :service_provider
end
