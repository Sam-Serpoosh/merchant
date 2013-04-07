class Address < ActiveRecord::Base
  attr_accessible :city, :line1, :line2, :state, :user_id, :zip

  has_many :orders
  belongs_to :user

  validates :line1, presence: true
  validates :city, presence: true
  validates :state, presence: true, format: /^[A-Z][A-Z]$/
  validates :zip, presence: true, format: /\d{5}/

  def to_s
    "#{line1}, #{city}, #{state} #{zip}"
  end
end
