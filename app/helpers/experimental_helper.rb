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
		Question.where(:tags => tag).blank? ? ["No question found for this tag"] :  Question.where(:tags => tag).map(&:title)
	end
end
