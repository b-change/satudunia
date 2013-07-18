class ContactController < ApplicationController
  layout "experiment"

  def index
    @contact = Contact.new()
  end
  
  def send_contact_us
    if @contact = Contact.create(params[:contact])
    	respond_to do |format|
    		format.html{redirect_to contact_path,notice:'Contact Submitted'}
    		format.json{render json: @contact }
    	end
    else
    	respond_to do |format|
    		format.html{redirect_to contact_path,alert:'Something went wrong'}
    		format.json{render json: @contact }
    	end

    end
  end
end
