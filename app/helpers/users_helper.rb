module UsersHelper
  # Return the gravatar image of the given user

  def gravatar_for(user, _options = { size: 50 })
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end

  def avatar_for_current_user(user)
    if user.avatar.attached?
      image_tag(url_for(current_user.avatar.variant(resize: '180x180', crop: '180x180+0+0')))
    else
      gravatar_for(user)
    end
  end

  def avatar_for_user(user)
    if user.avatar.attached?
      image_tag(url_for(user.avatar.variant(resize: '180x180', crop: '180x180+0+0')))
    else
      gravatar_for(user)
    end
  end

  def avatar_for_user_100(user)
    if user.avatar.attached?
      image_tag(url_for(user.avatar.variant(resize: '90x90', crop: '90x90+0+0')))
    else
      gravatar_for(user)
    end
  end

  def avatar_for_user_follow(user)
    if user.avatar.attached?
      image_tag(url_for(user.avatar.variant(resize: '70x70', crop: '70x70+0+0')))
    else
      gravatar_for(user)
    end
  end

  def avatar_for_post(user)
    if user.avatar.attached?
      image_tag(url_for(user.avatar.variant(resize: '45x45', crop: '45x45+0+0')))
    else
      gravatar_for(user)
    end
  end

  def first_name(name)
    name = name.split.first
    name = name.capitalize
    name
  end
end
