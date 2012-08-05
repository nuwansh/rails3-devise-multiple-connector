module ApplicationHelper

  def loggin_name(name, email)
    if name.nil?
      get_name_by_email_address(email)
    else 
      name
    end 
  end 

  def get_name_by_email_address(email)
    name = (/(.*[a-z0-9_.-]+)@/).match(email)[1]
  end 
end
