class Cart < ActiveRecord::Base

  belongs_to :user

  has_many :positions
  has_many :items, through: :positions

  #has_and_belongs_to_many :items
end
