class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def full_name
    self.last_name.to_s + ' ' + self.first_name
  end

end
