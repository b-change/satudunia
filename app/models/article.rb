class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include MongoidExt::Storage
  include MongoidExt::Slugizer

  slug_key :article_title, :unique => true

  referenced_in :user
  index :user_id

  field :article_title, :type => String
  field :article_body, :type => String
  field :is_active, :type => Boolean, :default => true
  field :is_archive, :type => Boolean, :default => false

  file_key :article_image, :max_length => 1.megabytes
  file_list :thumbnails

  attr_accessible :article_title, :article_body, :is_active, :is_archive, :article_image

  validates_presence_of :article_title, :message => "article title can't be blank"
  validates_presence_of :article_body, :message => "article body can't be blank"
  validates_uniqueness_of :article_title, :message => "article title is already taken"

  default_scope desc(:created_at)

  # def self.find_file_from_params(params, request)
  #   if request.path =~ %r{/(article_image|big|medium|small)/([^/\.\?]+)}
  #     @articles = Articles.find($2)
  #     article_image = @articles.has_article_image? ? @articles.article_image : Shapado::FileWrapper.new("#{Rails.root}/public/images/avatar-25.png", "image/png")
  #     case $1
  #     when "article_image"
  #       article_image
  #     when "big"
  #       @articles.thumbnails["big"] ? @articles.thumbnails.get("big") : article_image
  #     when "medium"
  #       @articles.thumbnails["medium"] ? @articles.thumbnails.get("medium") : article_image
  #     when "small"
  #       @articles.thumbnails["small"] ? @articles.thumbnails.get("small") : article_image
  #     end
  #   end
  # end

end
