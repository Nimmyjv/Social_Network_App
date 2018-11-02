module PhotosHelper
	def like_button(photo, current_user)
		like = Like.where(photo: photo, user: current_user)
		if like.present?
			link_to 'Unlike', toggle_like_photo_path(photo, user_id: current_user.id)
		else
			link_to 'Like', toggle_like_photo_path(photo, user_id: current_user.id)
		end
	end
end
