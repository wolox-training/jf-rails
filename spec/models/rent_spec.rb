require 'rails_helper'

describe Rent do
  subject(:rent) { create(:rent) }

  it { is_expected.to validate_presence_of :user_id }
  it { is_expected.to validate_presence_of :book_id }
  it { is_expected.to validate_presence_of :from }
  it { is_expected.to validate_presence_of :to }
  it { is_expected.to satisfy('from cannot be greater than to') { |rent| rent.from <= rent.to } }

  it { is_expected.to be_valid }
end
