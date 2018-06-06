RSpec.shared_context 'Authenticated User' do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }
  let!(:access_data) { user.create_new_auth_token }
  let!(:access_token) { access_data['access-token'] }
  let!(:client) { access_data['client'] }
  let!(:uid) { access_data['uid'] }

  before do
    request.headers['Access-Token'] = access_token
    request.headers['Client'] = client
    request.headers['Uid'] = uid
  end
end
