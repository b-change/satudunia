class ServiceProvider
  include Mongoid::Document
  include MongoidExt::Slugizer


  slug_key :name, :unique => true
  
  #paginates_per 25
  
  index :service_category_id
  
  referenced_in :service_category
  index :service_category_id

  references_many :service_provider_validates
  
  field :name, :type => String
  field :description, :type => String
  field :url, :type => String
  field :address, :type => String
  field :email, :type => String
  field :telephone, :type => String
  field :country, :type => String
  # newely added
  field :review_text, :type=>String, :default=>"It is a long established fact that a reader will be distracted by 
  the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a 
  more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look 
  like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default 
  model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions 
  have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."
  field :review_rating, :type=>Integer, :default => 0
  field :recommend, :type => Integer, :default => 0
  field :consultation, :type => String
  
  xapit do 
    text :name
    text :description
    text :url
    field :service_category_id
  end
  
  validates_presence_of :name, :message => "Service name can't be blank"
  validates_uniqueness_of :name, :message => "Service name is already taken"
  
  attr_accessible :name, :description, :url, :address, :email, :telephone, :country, :recommend

  def self.update_service_provider_views
    @service_providers_index_views = ViewsCount.where(:type => "service_providers_index").first
    if @service_providers_index_views == nil
      ViewsCount.create(:type => "service_providers_index", :count => 150)
    else
      @service_providers_index_views.count += 1
      @service_providers_index_views.save
    end
  end
end
