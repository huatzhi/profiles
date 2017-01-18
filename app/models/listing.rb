class Listing < ActiveRecord::Base
  enum category: {
    'apartment': 0,
    'terrace': 1,
    'bungalow': 2,
    'villa': 3
  }

  # Temp solution for limited time, not for long run.
  def type
    self.category
  end
end
