require 'rails_helper'

describe BookSuggestion do
  subject(:book_suggestion) { create(:book_suggestion) }

  it { is_expected.to be_valid }
end
