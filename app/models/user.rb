class User
  ROLES = {
    guide: 1,
    tourist: 2,
  }

  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  field :provider, type: String
  field :uid, type: String

  field :name, type: String
  field :role, type: Integer, default: 2
  field :kandy_register_response, type: Hash

  embeds_many :tour_links, inverse_of: :tourist

  index({provider: 1, uid: 1})

  after_create :register_in_kandy

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
    end
  end

  def register_in_kandy
    uid = email.gsub('@', '').gsub('.', '')[0..14]
    key = 'DATffefa3a877d644e09b4985e61abbdce8'
    url = 'https://api.kandy.io/v1.2/domains/users/user_id'
    res = RestClient.post "#{url}?key=#{key}&user_id=#{uid}&user_country_code=US", {}
    set kandy_register_response: JSON.parse(res)
  end

  def guide?
    role == self.class::ROLES[:guide]
  end

  def tourist?
    role == self.class::ROLES[:tourist]
  end

  def tours
    if guide?
      Tour.where owner: self
    else
      tour_links.map &:tour
    end
  end

  def kandy_id
    return unless kandy_register_response
    self['kandy_register_response'].fetch('result', {}).fetch('full_user_id', nil);
  end

  def kandy_password
    return unless kandy_register_response
    self['kandy_register_response'].fetch('result', {}).fetch('user_password', nil);
  end
end
