require 'digest/sha1'
class User
  # Virtual attribute for the unencrypted password
  attr_accessor :password

  validates_presence_of     :login
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..20, :if => :password_required?, :message => 'invalid. Needs to be 4 to 20 chars long'
  validates_confirmation_of :password,                   :if => :password_required?

  validates_length_of       :login,    :within => 4..20, :message => 'invalid. Needs to be 4 to 20 chars long'

  validates_presence_of     :email
  validates_length_of       :email,    :within => 3..100

  validates_format_of       :login,    :with => /^([-a-z0-9_]+)$/ , :message => 'not valid. Login can have lowercase letters, numbers and a hyphen or underscore. '
  validates_format_of       :email,    :with => /^([-a-zA-Z0-9\._]+)@([-a-zA-Z0-9\.]+[a-z]{2,})$/, :message  => 'not valid. Email address needs be something like mrinal.patua@bigpaunch.com'
  
  validates_uniqueness_of   :login, :email, :scope => :site_id
  before_save :downcase_email_and_login
  before_save :encrypt_password
  before_create :set_first_user_as_admin

  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation, :bio

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

protected


  # before filter 
  def encrypt_password
    return if password.blank?
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
    self.crypted_password = encrypt(password)
  end
    
  def password_required?
    crypted_password.blank? || !password.blank?
  end
  
  def set_first_user_as_admin
    self.admin = true if site and site.users.size.zero?
  end
  
  def downcase_email_and_login
    login.downcase!
    email.downcase!
  end
end