class Cart < ActiveRecord::Base

  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items


def total
    self.line_items.each.sum do |line_item|
      line_item.item.price * line_item.quantity
    end
  end

  def add_item(item_id)
    line_item = self.line_items.find_by(item_id: item_id)
    if line_item
      line_item.quantity += 1
      line_item.save
    else
      line_item = self.line_items.build(item_id: item_id)
    end
    line_item
  end

  def checkout
    self.status = "submitted"
    self.line_items.each do |line_item|
      item = Item.find(line_item.item_id)
      item.inventory -= line_item.quantity
      item.save
    end
    self.save
  end
 
end
