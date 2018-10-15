require 'rails_helper'

RSpec.describe Product, type: :model do
  category = Category.create!(name: 'test')
  subject {
    described_class.new(name: "test test", price: 64.99,
                      quantity: 10, category_id: category.id)
  }

  describe 'Validations' do
    # validation tests/examples here
    it 'should save successfully with all validations' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a price' do
      subject.price_cents = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a quantity' do
      subject.quantity = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a category' do
      subject.category_id = nil
      expect(subject).to_not be_valid
    end
  end
end
