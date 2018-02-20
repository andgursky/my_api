require 'rails_helper'

RSpec.describe Category, type: :model do
  it_behaves_like "Model"
  it { is_expected.to have_many(:products) }
end
