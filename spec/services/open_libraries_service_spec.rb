require 'rails_helper'

describe OpenLibraryService do
  include OpenLibraryStubs

  subject(:service) { described_class.new }

  describe '#book_info' do
    let!(:stub) { get_book_info }

    it 'makes a request to the open libraries service' do
      service.book_info('ISBN:0385472579')
      expect(stub).to have_been_requested
    end

    it 'returns an instance of Hash' do
      expect(service.book_info('ISBN:0385472579')).to be_an_instance_of(Hash)
    end
  end
end
