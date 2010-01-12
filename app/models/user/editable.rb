module User::Editable
  def editable_by?(user)
    user && (user.id == user_id || user.moderator_of?(forum))
  end
end