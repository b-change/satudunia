class StaticPage
  include Mongoid::Document
  include Mongoid::Timestamps

  field :static_key, :type => String
  field :static_content, :type => String

  field :latitude, :tipe => String
  field :longitude, :tipe => String
  field :street_address, :tipe => String

  validates_presence_of :static_key
  validates_presence_of :latitude, :if => :is_contact_page?, :message => "Latitude can't be blank!"
  validates_presence_of :longitude, :if => :is_contact_page?, :message => "Longitude can't be blank!"
  validates_presence_of :street_address, :if => :is_contact_page?, :message => "Street Address can't be blank!"

  validates_uniqueness_of :static_key
  validates_inclusion_of :static_key, :in => %w( about tos eula privacy contact), :message => "Static page not registered yet."

  attr_accessible :static_content, :latitude, :longitude, :street_address, :static_key

  def is_contact_page?
    static_key.eql? "contact"
  end

  def street_address_safe
    HTMLEntities.new.encode street_address
  end
end