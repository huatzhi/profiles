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

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :basic_search,
      :with_type,
      :with_min_room,
      :with_min_bath_room
    ]
  )

  scope :with_type, ->(type) { where category: type }
  scope :with_min_room, ->(min_room) { where("room_nums >= ?", "#{min_room}") }
  scope :with_min_bath_room, ->(min_bath_room) { where("bathroom_nums >= ?", "#{min_bath_room}") }

  def self.options_for_sorted_by
    [
      ['Title (a-z)', 'title_asc'],
      ['Location (a-z)', 'location_asc'],
      ['Room nums (least first)', 'room_nums_asc'],
      ['Room nums (most first)', 'room_nums_desc'],
      ['Registration date (newest first)', 'created_at_desc'],
      ['Registration date (oldest first)', 'created_at_asc']
    ]
  end
end
