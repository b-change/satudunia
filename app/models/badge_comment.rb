class BadgeComment
  include Mongoid::Document
  include Mongoid::Ancestry
  include Mongoid::Timestamps
  has_ancestry
  field :user_id , :type => String
  field :message, :type => String
  field :ancestry, :type => String
end
