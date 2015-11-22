class Tour
  include Mongoid::Document

  mount_uploader :tour_image, TourImageUploader

  field :title, type: String
  field :country, type: String
  field :city, type: String
  field :language, type: String
  field :date, type: Time
  field :latitude, type: Float
  field :longitude, type: Float

  belongs_to :owner, class_name: 'User'

  def owner
    @owner ||= User.find_by(id: owner_id)
  end
end
