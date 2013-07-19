class ContactController < ApplicationController
  layout "experiment"

  def index
    @contact = Contact.new()
  end
  # send contact us action
  def send_contact_us
    #success case
    if @contact = Contact.create(params[:contact])
    	respond_to do |format|
    		format.html{redirect_to contact_path,notice:'Contact Submitted'}
    		format.json{render json: @contact }
    	end
    #failure case
    else
    	respond_to do |format|
    		format.html{redirect_to contact_path,alert:'Something went wrong'}
    		format.json{render json: @contact }
    	end
    end
    #conditiona statement ends here
  end
end
