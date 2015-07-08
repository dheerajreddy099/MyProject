module Chef::SaasUser

  def self.[](arg)
    if self.exists?(arg) then
      if arg.is_a?(String) then
        return Chef::DataBag.load("saas_users")[arg]
      elsif arg.is_a?(Integer) then
        return Chef::DataBag.load("saas_users").find{ |id,item| item["uid"] == arg }
      else
        return nil
      end
    else
      return nil
    end
  end

  def self.exists?(arg) 
    if arg.is_a?(String) then
      return Chef::DataBag.load("saas_users").keys.include?(arg)
    elsif arg.is_a?(Integer) then
      return Chef::DataBag.load("saas_users").any?{ |id,item| item["uid"] == arg }
    else
      return nil
    end
  end
  
end