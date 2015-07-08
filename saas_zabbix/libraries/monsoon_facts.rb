class MonsoonFacts

def initialize(platform_family)
    if ["suse", "rhel", "debian"].include?(platform_family) then
       @monsoon_facts_yaml="/etc/mcollective/monsoonfacts.yaml"
    elsif ["windows"].include?(platform_family)
       @monsoon_facts_yaml='C:\opt\mcollective\etc\mcollective\monsoonfacts.yaml'
    end
end

def getFQDN(domain)
    if File.exist?(@monsoon_facts_yaml) then
        File.open(@monsoon_facts_yaml, 'r') do |f1|  
          while line = f1.gets  
            if line.start_with?('name:') then
                temp=line.split('name:')
                if temp.length==2 then
                    hostname = temp[1].strip()
                else
                    return nil
                end
                if domain!=nil and domain.empty?()==false then
                    hostname = "#{hostname}.#{domain}"
                end
                #puts hostname
                return hostname
            end
          end  
        end  
    else
        return nil
    end
end



end