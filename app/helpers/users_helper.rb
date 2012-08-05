module UsersHelper
  def user_role_name(id)
    roles = ["","Admin", "Subscriber"]
    roles[id]
  end
end
