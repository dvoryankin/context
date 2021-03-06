class User < ApplicationRecord
  attr_accessor :password

  email_regex = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i

  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: email_regex }
  validates :password, presence: true,
                       confirmation: true, on: :create
  validates :password_confirmation, presence: true

  has_many :tasks

  before_save :hash_password
  after_destroy :show_message

  def hash_password
    puts '[User]: create hashed password before save user'
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.hashed_password = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def to_s
    puts "[User]: id=#{id}; email=#{email}"
  end

  def self.authenticate(email, password)
    user = where(email: email).first
    if user && user.hashed_password == BCrypt::Engine.hash_secret(password, user.salt)
      user
    end
  end

  def show_message
    puts "[User]: Object #{self} has been destroyed"
  end
end
