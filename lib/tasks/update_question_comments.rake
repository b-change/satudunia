namespace :update_question_comments do
  desc "TODO"
  task :update_question_comments => :environment do
  		@commentFirst = "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old."
  		@commentSecond = "Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy."
  		Question.all.each do |ques|
        		ques.comments.delete_all
  			ques.comments.create({user_id:ques.user_id,body:@commentFirst})
  			ques.comments.create({user_id:ques.user_id,body:@commentSecond})
  		end
  end

end
