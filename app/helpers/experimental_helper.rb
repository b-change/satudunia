module ExperimentalHelper
	def check_valid
	  (params[:controller] == "contact" && params[:action] == "index") || (params[:controller] == "users" && params[:action] == "new") || (params[:controller] == "devise/unlocks" && params[:action] == "new")
	end

	def check_pre_loader
		(params[:controller] == "experimental/experimental" && params[:action] == "index") 
	end

	def filter_updated_at
		return [@privacy, @eula, @tos, @about].sort_by{|e| e[:updated_at]}
	end
end
