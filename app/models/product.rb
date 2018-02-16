class Product < ApplicationRecord
  validates :price, numericality: true
  validates :name, presence: true, uniqueness: true
  belongs_to :category
  after_save :set_current_product_count
  after_destroy :set_current_product_count
  validate :non_zero_price

  private

  def set_current_product_count
    category = Category.find(category_id.to_i)
    Category.transaction do
      category.update(products_count: category.products.count)
    end
  end

  def non_zero_price
    errors.add(:price, 'should be grater then zero!') if price <= 0
  end
end
