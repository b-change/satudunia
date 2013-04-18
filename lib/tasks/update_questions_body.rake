namespace :update_questions_body do
  desc "TODO"
  task :update_questions_body => :environment do
	Question.update_all(:body=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum scelerisque arcu ut turpis tincidunt gravida. Proin luctus, justo in egestas pellentesque, leo leo laoreet nibh, in fringilla diam dolor a sapien. Phasellus nulla turpis, tristique eget convallis vel, volutpat et tortor. Nam porttitor, velit sed dapibus congue, nibh dolor ullamcorper sapien, non feugiat orci tortor non massa. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Aliquam volutpat purus ac nisi accumsan viverra. Proin lobortis iaculis lacus, eu varius est volutpat quis. Nullam ac augue non dolor accumsan ornare")
	#Question.all.each do |question|
	#	Question.update_all(:body => question.body+" this is my text")
	#end

  end
end
