class AddMembersController < ApplicationController
  before_action :manager_user
  before_action :correct_user, only: [:update]

  def index
    @users = User.search_user(params[:q]).division_empty.paginate(page: params[:page],per_page: Settings.requests.per_page)
  end

  def update
    if @user.update(division_id: current_division.id)
      flash[:success] = t ".update"
      redirect_to manage_members_path
    else
      flash[:failure] = t ".update_fault"
      redirect_to manage_members_path
    end
  end

  private

  def manager_user
    redirect_to root_path unless current_user.admin?
  end

  def correct_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:empty] = t "member.not_exits"
    redirect_to root_path
  end
end
