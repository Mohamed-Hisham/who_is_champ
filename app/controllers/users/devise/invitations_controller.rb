class Users::Devise::InvitationsController < Devise::InvitationsController
  before_action :prepare_game, except: :edit

  # GET /users/invitation/new
  def new
    @creator = current_creator
    super
  end

  # POST /users/invitation
  def create
    self.resource = invite_resource

    if resource.errors.empty? && !params[:user][:email].nil?
      yield resource if block_given?
      set_flash_message :notice, :send_instructions, :email => self.resource.email if self.resource.invitation_sent_at
      respond_with resource, :location => creator_game_path(current_creator, @game)
    else
      flash[:error]= "The email you input is either invalid or empty. Please input a valid one."
      redirect_to creator_game_path(current_creator, @game)
    end
  end

  # GET /users/invitation/accept?invitation_token=abcdef
  def edit
    resource.invitation_token = params[:invitation_token]
    render :edit
  end

  # PUT /users/invitation
  def update
    self.resource = accept_resource

    if resource.errors.empty?
      yield resource if block_given?
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message :notice, flash_message
      sign_in(resource_name, resource)
      respond_with resource, :location => after_accept_path_for(resource)
    else
      respond_with_navigational(resource){ render :edit }
    end
  end

  protected

  def invite_resource(&block)
    resource_class.invite!(invite_params, current_inviter, &block)
  end

  def accept_resource
    resource_class.accept_invitation!(update_resource_params)
  end

  def current_inviter
    authenticate_inviter!
  end

  def has_invitations_left?
    unless current_inviter.nil? || current_inviter.has_invitations_left?
      self.resource = resource_class.new
      set_flash_message :alert, :no_invitations_remaining
      respond_with_navigational(resource) { render :new }
    end
  end

  def resource_from_invitation_token
    unless params[:invitation_token] && self.resource = resource_class.find_by_invitation_token(params[:invitation_token], true)
      set_flash_message(:alert, :invitation_token_invalid)
      redirect_to after_sign_out_path_for(resource_name)
    end
  end

  def invite_params
    devise_parameter_sanitizer.for(:invite) << :game_id
    devise_parameter_sanitizer.sanitize(:invite)
  end

  def update_resource_params
    devise_parameter_sanitizer.for(:accept_invitation) << :name
    devise_parameter_sanitizer.for(:accept_invitation) << :email
    devise_parameter_sanitizer.for(:accept_invitation) << :avatar
    devise_parameter_sanitizer.for(:accept_invitation) << :game_id
    devise_parameter_sanitizer.sanitize(:accept_invitation)
  end

  def prepare_game
    @game = Game.find(params[:user][:game_id]) if params[:user][:game_id]
  end

  # def users_params
  #   params.require(:invite).permit(:game_id)
  # end
end