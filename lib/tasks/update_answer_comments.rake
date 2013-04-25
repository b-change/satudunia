namespace :update_answer_comments do
  desc "TODO"
  task :update_answer_comments => :environment do
	@commentFirst = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable"
	@commentSecond = "If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet."
	@commentThree = "It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
	Answer.all.each do |ans|
		ans.comments.delete_all
		ans.comments.create({user_id:ans.user_id,body:@commentFirst})
		ans.comments.create({user_id:ans.user_id,body:@commentSecond})
		ans.comments.create({user_id:ans.user_id,body:@commentThree})
	end
  end

end
