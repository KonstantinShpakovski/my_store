class Item < ActiveRecord::Base
  #attr_accessible :price, :name, :real, :weight, :description

  validates :price, numericality: {greater_than: 0, allow_nil: true}
  validates :description, :name, presence:  true


  has_many :positions
  has_many :carts, through: :positions

  has_many :comments, as: :commentable

  #has_and_belongs_to_many :carts
  #belongs_to :category

  after_initialize {} #{puts "initialized"} # Item.new; Item.first; Item.find()
  after_save {}       #{puts "saved"} #Item.save; Item.create; item.update_attributes()
  after_create {}     #{puts "created"} {ItemMailer.new_item_created(self).deliver} {category.inc(:items_count, 1)}
  after_update {}     #{puts "updated"}
  after_destroy{}     # {puts "destroyed"} {category.inc(:items_count, -1)}

end
