class ContactController < ApplicationController
  layout "experiment"

  def index
    add_breadcrumb "Contact Us", contact_index_path.gsub("/","")
    @contact = Contact.new()
  end

  def create
    
    if recaptcha_valid?
      @contact= Contact.create(params[:contact])
      if @contact.save
        redirect_to contact_index_path 
        flash[:notice] = "Thank You"
      else
        redirect_to contact_index_path
        flash[:alert] = "Something Went wrong"
      end
    else
      respond_to do |format|
        format.html{redirect_to contact_index_path,alert:'Please re-enter captcha correctly '}
        
      end
    end
  end
  # send contact us action
  # def send_contact_us
    
  #   #success case
  #   if recaptcha_valid?
  #     if @contact = Contact.create(params[:contact])
  #     	respond_to do |format|
  #     		format.html{redirect_to contact_path,notice:'Contact Submitted'}
  #     		format.json{render json: @contact }
  #     	end
  #     #failure case
  #     else
  #     	respond_to do |format|
  #     		format.html{redirect_to contact_path,alert:'Something went wrong'}
  #     		format.json{render json: @contact }
  #     	end
  #     end
  #   else
  #     respond_to do |format|
  #       format.html{redirect_to contact_path,alert:'Please re-enter captcha correctly '}
  #       format.json{render json: @contact }
  #     end
  #   end
  #   #conditiona statement ends here
  # end
end
