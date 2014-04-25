require 'digest/sha1'

class InviteCode
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  include Mongoid::Timestamps
  # include MultiauthSupport
  # include MongoidExt::Storage
  include Shapado::Models::GeoCommon
  include Shapado::Models::Networks
  field :code, :type => String
  field :email, :type => String, :required => true
  validates_uniqueness_of   :email
  # belongs_to :user

  index :user_id
end
