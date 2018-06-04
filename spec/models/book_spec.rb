require 'rails_helper'

describe Book do
  subject(:book) { create(:book) }
  
  it '#validate' do
    is_expected.to validate_presence_of :genre
    is_expected.to validate_presence_of :author
    is_expected.to validate_presence_of :image
    is_expected.to validate_presence_of :title
    is_expected.to validate_presence_of :publisher
    is_expected.to validate_presence_of :year
  end

  it 'valid book' do
    is_expected.to be_valid
  end

end
