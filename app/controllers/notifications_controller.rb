class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.includes([:visitor, :visited, :menu]).page(params[:page]).per(20)
    @notifications.where(checked: false).each do |notification|
      notification.update_attribute(:checked, true)
    end
  end
end
