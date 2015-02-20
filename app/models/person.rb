class Person < ActiveRecord::Base

def full_name
  "#{title} #{first_name} #{last_name}"
end

end
