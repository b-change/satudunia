module BadgeCommentsHelper

	def nested_messages(messages)
    messages.map do |message, sub_messages|
      render(message)+ content_tag(:div, nested_messages(sub_messages), :class => "nested_messages")
    end.join.html_safe
  end

  def commentor_image(badge_comment)
  	avatar_user_path(User.find(badge_comment.user_id))
  end

  def commentor_name(badge_comment)
  	User.find(badge_comment.user_id).name
  end
end
