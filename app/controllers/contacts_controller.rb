class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]

  # GET /contacts
  def index
    contacts = Contact.where(user_id: current_user.id)
                  .paginate(page: params[:page], per_page: 20)

    render json: contacts, status: 200
  end

  # GET /contacts/:id
  def show
    if @contact
      render_successful
    else
      render_not_found
    end
  end

  # POST /contacts
  def create
    contact = Contact.new(contact_params)
    contact.user = current_user

    if contact.save
      render_successful(contact)
    else
      render_invalid(contact.errors.messages)
    end
  end

  # PUT /contacts/:id
  def update
    return render_not_found unless @contact

    if @contact.update(contact_params)
      render_successful
    else
      render_invalid
    end
  end

  # DELETE /contacts/:id
  def destroy
    return render_not_found unless @contact

    if @contact.destroy
      render_successful
    else
      render_error
    end
  end

  def contact_params
    params.permit(:first_name, :last_name, :phone, :address)
  end

  def set_contact
    @contact = Contact.where(id: params[:id], user_id: current_user.id).first
  end

  def render_successful(contact = nil)
    contact ||= @contact

    render json: contact, status: 200
  end

  def render_not_found
    render json: { message: "Contact not found" }, status: 404
  end

  def render_invalid(errors)
    render json: { errors: errors }, status: 422
  end
end
