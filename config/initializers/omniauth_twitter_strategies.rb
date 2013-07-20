OmniAuth::Strategies::Twitter.class_eval do 
  def user_info
    user_hash = self.user_hash
    {
      'nickname' => user_hash['screen_name'],
      'name' => user_hash['name'] || user_hash['screen_name'],
      'location' => user_hash['location'],
      'image' => user_hash['profile_image_url'],
      'description' => user_hash['description'],
      'urls' => {
        'Website' => user_hash['url'],
        'Twitter' => "http://twitter.com/#{user_hash['screen_name']}"
      },
    }
  end
end