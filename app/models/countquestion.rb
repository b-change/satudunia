class Countquestion
  include Mongoid::Document
  include Mongoid::Timestamps
  field :ip_add, :type => String
  field :qus_count, :type => Integer
  field :question_id ,:type=>String
  field :created_at , :type => DateTime 
  field :updated_at , :type => DateTime
  attr_accessible :ip_add, :qus_count,:qus_count,:question_id,:created_at,:update_at,:user_id
  referenced_in :user
  referenced_in :question
end
