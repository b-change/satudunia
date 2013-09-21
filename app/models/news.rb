class News
  include Mongoid::Document
  include Mongoid::Timestamps
  include MongoidExt::Storage
  include MongoidExt::Slugizer
  include Mongoid::Rateable

  RATING_RANGE = (1..5)
  
  slug_key :news_title, :unique => true
  
  paginates_per 25

  referenced_in :user
  index :user_id

  field :news_title, :type => String
  field :news_body, :type => String
  field :is_active, :type => Boolean, :default => true
  field :is_archive, :type => Boolean, :default => false

  file_key :news_image, :max_length => 1.megabytes
  file_list :thumbnails

  attr_accessible :news_title, :news_body, :is_active, :is_archive, :news_image

  validates_presence_of :news_title, :message => "News title can't be blank"
  validates_presence_of :news_body, :message => "News body can't be blank"
  validates_uniqueness_of :news_title, :message => "News title is already taken"

  default_scope desc(:created_at)

  def self.find_file_from_params(params, request)
    if request.path =~ %r{/(news_image|big|medium|small)/([^/\.\?]+)}
      @news = News.find($2)
      news_image = @news.has_news_image? ? @news.news_image : Shapado::FileWrapper.new("#{Rails.root}/public/images/avatar-25.png", "image/png")
      case $1
      when "news_image"
        news_image
      when "big"
        @news.thumbnails["big"] ? @news.thumbnails.get("big") : news_image
      when "medium"
        @news.thumbnails["medium"] ? @news.thumbnails.get("medium") : news_image
      when "small"
        @news.thumbnails["small"] ? @news.thumbnails.get("small") : news_image
      end
    end
  end
end