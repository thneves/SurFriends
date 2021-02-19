module UsersHelper

  #Return the gravatar image of the given user

  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def avatar_for(user)
    if user.avatar.attached?
      image_tag(url_for(user.avatar))
    else
      gravatar_for
    end
  end    
end
