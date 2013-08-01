module ExperimentalHelper
	def check_valid
	  (params[:controller] == "contact" && params[:action] == "index") || (params[:controller] == "users" && params[:action] == "new") || (params[:controller] == "devise/unlocks" && params[:action] == "new")
	end
end
