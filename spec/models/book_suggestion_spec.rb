require 'rails_helper'

describe BookSuggestion do
  subject(:book_suggestion) { create(:book_suggestion) }

  it { is_expected.to validate_presence_of :author }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :link }

  it { is_expected.to be_valid }
end
