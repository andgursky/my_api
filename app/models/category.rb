class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :products, class_name: 'Product', dependent: :destroy
  after_initialize :init_default_products_count

  private

  def init_default_products_count
    self.products_count ||= 0
  end
end
