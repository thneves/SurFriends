module ApplicationHelper
  include SessionsHelper
  include UsersHelper

  def full_title(page_title = '')
    base_title = 'Surfriends'
    if page_title.empty?
      base_title
    else
      page_title + ' - ' + base_title
    end
  end

  def header_logged_in
    render 'layouts/header_logged' if logged_in?
  end

  def user_post_avatar(users, poster)
    users.with_attached_avatar.each do |u|
      next unless u == poster

      return image_tag(url_for(u.avatar.variant(resize: '45x45', crop: '45x45+0+0'))) if u.avatar.attached?

      gravatar_for(u)
    end
  end

  def home_page
    if logged_in?
      render 'shared/home_logged_in'
    else
      render 'shared/home_not_logged'
    end
  end
end
