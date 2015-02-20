class Person < ActiveRecord::Base

  validate :first_name_or_title
  validates :last_name, presence: true

  def full_name
    "#{title} #{first_name} #{last_name}"
  end

  def first_name_or_title
    if (title.nil? || title.empty?) && (first_name.nil? || first_name.empty?)
      errors.add(:title, " or First name must be entered")
    end
  end

end
