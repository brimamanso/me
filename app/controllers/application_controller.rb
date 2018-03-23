class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :email, :password, :remember_me])
  end

  def render_404
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
    end
  end

  def rescue_from_fk_contraint
    begin
      yield
    rescue ActiveRecord::InvalidForeignKey
      # Flash and render, render API json error... whatever
    end
  end

end