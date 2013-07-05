namespace :content do
  desc "updating data for experimental question answer"
  task :experimental_question => :environment do
  	@content = "Learn from other people's experience of living with HIV - 
  	the diversity of answers might be the food for thought that you needed. 
  	Have you ever wanted to know how others cope with their HIV diagnosis? 
  	Do you want to learn how others found a way to disclose their status to 
  	the people they love? How about questions about sex? Now is your chance to 
  	ask and answer questions from people just like you - people who want to live, 
  	laugh, love, have fun and stay healthy, positively."
		StaticPage.create!({static_key: "qus_ans",static_content:@content})
  end
  desc "updating data for experimental comment"
  task :experimental_comments => :environment do
  	@content = "Find HIV health specialists in your local areas and help us map 
  	other services that people should know about.Do you know the HIV health specialists
  	 in your local areas? Do you know what other options are available? How 
  	 would you describe the quality of service you received? Check out our map of 
  	 services available near you. Leave feedback about the services that are available. 
  	 And help us map more services that other people living with HIV should know about."
		StaticPage.create!({static_key: "comments",static_content:@content})
  end

  desc "updating data for experimental service map"
  task :experimental_service_map => :environment do
  	@content = "Get the information you need to know and stay in touch via our regular 
  	newsletter or social media feeds.Whether you're newly diagnosed, or you've been 
  	living with HIV for years, it's important to know the basics and stay up-to-date 
  	with breakthroughs in health and living well with HIV."
  	StaticPage.create!({static_key: "service",static_content:@content})
  end

end
