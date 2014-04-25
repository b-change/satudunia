class Feedback
  include Mongoid::Document
  include Mongoid::Timestamps
  field :your_feedback, :type => String
  field :name, :type => String
  validates_length_of       :name,     :maximum => 30
end
