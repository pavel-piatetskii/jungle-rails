class Sale < ActiveRecord::Base

  # Class method
  def self.active
    where("sales.starts_on <= ? AND sales.ends_on >= ?", Date.current, Date.current)
  end
  # /Class method

  def finished?
    ends_on < Date.current
  end

  def upcoming?
    starts_on > Date.current
  end

  def active?
    !finished? && !upcoming?
  end

end
