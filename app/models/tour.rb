class Tour
  include Mongoid::Document
  field :country, type: String
  field :city, type: String
  field :language, type: String
  field :date, type: Time
  field :owner_id, type: String

  def owner
    @owner ||= User.find_by(id: owner_id)
  end
end
