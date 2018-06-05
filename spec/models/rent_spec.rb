require 'rails_helper'

describe Rent do
  subject(:rent) { create(:rent) }

  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:book) }
  it { is_expected.to validate_presence_of(:from) }
  it { is_expected.to validate_presence_of(:to) }
  it { expect(rent.from).to be <= rent.to }

  it { is_expected.to be_valid }
end
