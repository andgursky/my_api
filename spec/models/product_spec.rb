require 'rails_helper'

RSpec.describe Product, type: :model do
  it_behaves_like "Model" do
    before :each do
      allow_any_instance_of(described_class).to receive(:non_zero_price)
        .and_return true
      allow(subject).to receive(:set_current_product_count).and_return true
    end
  end
  it { is_expected.to validate_numericality_of(:price) }
  it { is_expected.to belong_to(:category) }
end
