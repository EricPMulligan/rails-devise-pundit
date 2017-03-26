class LabelsController < ApplicationController
  before_action :find_user

  def new
    @label = Label.new(user: @user)
    authorize @label
    @label
  end

  def create
    @label = Label.new(
      user:   @user,
      name:   create_params[:name],
      colour: create_params[:colour]
    )

    @label.save!
    redirect_to users_path, notice: I18n.t('labels.created')
  rescue ActiveRecord::RecordInvalid
    flash.now[:alert] = if @label.errors.key?(:user) && @label.errors[:user].include?('has already been taken')
                          I18n.t('labels.errors.unique')
                        else
                          @label.errors.full_messages.join('<br />')
                        end
    render :new
  end

  def destroy
    @label = Label.find(params[:id])
    @label.destroy!
    redirect_to users_path, notice: I18n.t('labels.deleted')
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def create_params
    params.require(:label).permit(:name, :colour)
  end
end
