class TourLink
  STATES = %w(scheduled started finished)

  include Mongoid::Document

  field :state

  belongs_to :tour
  embedded_in :tourist, class_name: 'User'

  STATES.each { |s| define_method("#{s}?") { state == s } }
end
