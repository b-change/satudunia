class Announcement
  include Mongoid::Document
  include Mongoid::Timestamps
  include MongoidExt::Storage
  include MongoidExt::Slugizer
  include Mongoid::Rateable

  RATING_RANGE = (1..5)

  slug_key :message, :unique => true
  identity :type => String

  field :message, :type => String
  field :starts_at, :type => Timestamp
  field :ends_at, :type => Timestamp

  field :only_anonymous, :type => Boolean, :default => false
  file_key :announcement_image, :max_length => 1.megabytes
  file_list :thumbnails
  referenced_in :group

  validates_presence_of :message
  validates_presence_of :starts_at
  validates_presence_of :ends_at
  validates_length_of   :message,     :minimum => 5

  validate :check_dates, :on => :create

  def self.find_file_from_params(params, request)
    
    if request.path =~ %r{/(announcement_image|big|medium|small)/([^/\.\?]+)}
      @announcement = Announcement.find($2)
     announcement_image = @announcement.has_announcement_image? ? @announcement.announcement_image : Shapado::FileWrapper.new("#{Rails.root}/public/images/avatar-25.png", "image/png")
      case $1
      when "announcement_image"
        announcement_image
      when "big"
        @announcement.thumbnails["big"] ? @announcement.thumbnails.get("big") : announcement_image
      when "medium"
        @announcement.thumbnails["medium"] ? @announcement.thumbnails.get("medium") : announcement_image
      when "small"
        @announcement.thumbnails["small"] ? @announcement.thumbnails.get("small") : announcement_image
      end
    end
  end

  protected
  def check_dates
    if self.ends_at > Time.zone.now.yesterday
      if self.starts_at < Time.zone.now.yesterday
        self.errors.add(:starts_at, "Starting date should be setted to a future date")
      end

      if self.ends_at <= self.starts_at
        self.errors.add(:ends_at, "Ending date should be greater than starting date")
      end
    else
      self.errors.add(:ends_at, "Ending date should be greater than yesterday")
    end
    return true
  end
end
