class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
    before_action :check_ownership, only: [:edit, :update]
    respond_to :html, :js
  
    def show
      @activities = PublicActivity::Activity.where(owner: @user).order(created_at: :desc).paginate(page: params[:page], per_page: 100)
    end
  
    def edit
    end

    def search
      @user = User.search(params[:search])
    end

    def update
      if @user.update(user_params)
        redirect_to user_path(@user)
      else
        render :edit
      end
    end

    def index
      @users = User.where.not("id = ?",current_user.id).order("created_at DESC")
      @chats = Chat.involving(current_user).order("created_at DESC")
    end
  
    def deactivate
    end
  
    def friends
      @friends = @user.following_users.paginate(page: params[:page])
    end
  
    def followers
      @followers = @user.user_followers.paginate(page: params[:page])
    end
 
    private
  
    def user_params
      params.require(:user).permit(:name, :about, :avatar, :cover,
                                   :sex, :date_of_birth, :location, :phone_number, :Hobies, :Interests,
                                   :Likes, :Website, :Goals, :Skills, :Nationality, :Accomplishments, 
                                   :school, :School_Name, :Courses, :Profession, :Experiences, :Voluntering_Work, 
                                   :Role_Model, :Favourite_Musicians, :Favourite_Sports, :Favourite_TVshows, :Favourite_Footballers, 
                                   :Favourite_Subjects, :Favourite_Teachers, :Favourite_Professors, :Favourite_Roommate, :Best_Friends,
                                   :Favourite_Food, :Favourite_Basketball_Players, :Favourite_Countries, :Favourite_Car, :Favourite_Songs,
                                   :Favourite_Youtubers, :Favourite_Schools, :Favourite_University, :Favourite_Animals, :Favourite_Seasons,
                                   :Favourite_Pet, :Favourite_Brand, :Favourite_Footwears, :Relationship_status, :school_type,
                                   :Favourite_Movies, :Favourite_Books, :Favourite_Time_of_sleep, :Allergies, :Business_Ventures,
                                   :bio, :Favourite_Destinations, :wish, :believes, :Friends_with_benefits, :passions, :Favourite_Quote,
                                   :why_are_you_on_earth, :Core_Values, :strengths, :Leadership_Styles, :Native_Language, 
                                   :Majors, :Minors)
    end
  
    def check_ownership
      redirect_to current_user, notice: 'Not Authorized' unless @user == current_user
    end
  
    def set_user
      @user = User.friendly.find_by(slug: params[:id]) || User.find_by(id: params[:id])
      render_404 and return unless @user
    end
end