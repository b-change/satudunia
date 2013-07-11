namespace :renametask do
  desc "TODO"
  task :rename_slogan_slug => :environment do
  	Group.last.rename(:slogan_short_ask,:block_one_header)
  	Group.last.rename(:slogan_long_ask,:block_one_info)
  	Group.last.rename(:slogan_short_location,:block_two_header)
  	Group.last.rename(:slogan_long_location,:block_two_info)
  	Group.last.rename(:slogan_short_sign,:block_three_header)
  	Group.last.rename(:slogan_long_sign,:block_three_info)
  end

end
