module ExperimentalHelper
	def check_valid
	  (params[:controller] == "contact" && params[:action] == "index") || (params[:controller] == "users" && params[:action] == "new") || (params[:controller] == "devise/unlocks" && params[:action] == "new") || (params[:controller] == "users" && params[:action] == "edit")

	end

	def check_pre_loader
		(params[:controller] == "experimental/experimental" && params[:action] == "index") 
	end

	def change_lower_tab
		(params[:controller] == "experimental/experimental" && params[:action] == "dashboard") 
	end


	def filter_updated_at
		return [@privacy, @eula, @tos, @about].sort_by{|e| e[:updated_at]}.reverse
	end

	def get_country_name(service_providers)
		return service_providers.map(&:country).map(&:capitalize).uniq.reject { |c| c.empty? }
	end

	def get_questions_from_tag(tag)
		Question.where(:tags => tag).blank? ? ["<div id= 'message' class='info'><p>Sorry, there was no activity found. Please try a different filter.</p></div>".html_safe] :  Question.where(:tags => tag).map{|d| d.title.gsub('?','').strip}
	end

	def fetch_latest_comments
		@question_comments = []
		@answer_comments = []
		@question_with_comments_id =  Question.where(:comments.ne => nil).map(&:id)
		@answer_with_comments_id =  Answer.where(:comments.ne => nil).map(&:id)
		@question_with_comments_id.each do |question|
			@question_comments << Question.find(question).comments.order_by(:'updated_at'.desc)
		end
		@answer_with_comments_id.each do |answer|
			@answer_comments << Answer.find(answer).comments.order_by(:'updated_at'.desc)
		end
		return (@question_comments + @answer_comments)
	end

	def tags_collection_footer
		Tag.all.in_groups(4,nil)
	end
end
