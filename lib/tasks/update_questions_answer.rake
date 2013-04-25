namespace :update_questions_answer do
  desc "TODO"
  task :update_questions_answer => :environment do
	Answer.all.delete
	Question.all.each do |question|
		@answerBody = "Donec scelerisque tristique libero, a blandit ipsum pharetra non. Sed et lectus leo, in hendrerit ligula. Sed consequat dui eu metus vulputate vitae sollicitudin mauris facilisis. Nulla scelerisque blandit arcu. Cras semper tortor in mauris semper scelerisque et vitae felis. Duis sollicitudin, libero auctor dignissim ornare, nibh felis ornare massa, a gravida velit augue quis mauris. Aenean sed augue vitae lectus vulputate rutrum. Quisque id nulla eleifend sapien fermentum tristique. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Suspendisse mollis, augue et hendrerit scelerisque, lectus dui ullamcorper nisi, ac pretium dui sapien vitae nisl. Nulla viverra sem est, sit amet mollis neque. Suspendisse potenti. Nullam dapibus ultricies neque, et pellentesque massa mattis vitae. Sed ac enim erat. Suspendisse potenti. Praesent ut justo lorem."
		@answerBody2 = "Maecenas vel cursus nisi. Sed hendrerit justo eu mi vestibulum molestie. Etiam rhoncus dapibus laoreet. Fusce mattis, metus ac vulputate venenatis, urna mi bibendum sapien, facilisis luctus ante leo sed velit. Ut a massa eros. Etiam iaculis dolor vitae mi sodales ac consectetur est dictum. Maecenas luctus tristique risus a pellentesque. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Morbi blandit mi dapibus eros scelerisque in luctus magna dignissim. Phasellus lorem ipsum, blandit ut egestas in, mattis eu eros. Cras quis nunc eget eros ullamcorper congue."
		Answer.create({question_id:question.id,group_id:question.group_id,user_id:question.user_id,body:@answerBody})
		Answer.create({question_id:question.id,group_id:question.group_id,user_id:question.user_id,body:@answerBody2})
	end
  end

end
