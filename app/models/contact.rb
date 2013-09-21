class Contact
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String, :required => true
  field :email, :type => String, :required => true
  field :comment, :type => String, :required => true
  field :company_name, :type => String, :required => true
  field :company_website, :type => String, :required => true
  field :country_code, :type => String, :required => true
  field :area_code, :type => Integer, :required => true
  field :phone_number, :type => String, :required => true
  field :country, :type=> String
  field :interested_in, :type => String, :required => true
  field :prefer_contact, :type => String, :required => true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates_presence_of :name
  validates_presence_of :comment
end
