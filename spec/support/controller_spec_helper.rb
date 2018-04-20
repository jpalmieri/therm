module ControllerSpecHelper
  # generate tokens from user id
  def token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  def expired_token_generator(user_id)
    JsonWebToken.encode({ user_id: user_id }, (Time.now.to_i - 10))
  end

  def valid_headers
    {
      'Authorization' => token_generator(user.id),
      'Content-Type' => 'application/json'
    }
  end

  def invalid_headers
    {
      'Authorization' => nil,
      'Content-Type' => 'application/json'
    }
  end
end

RSpec.shared_examples "other user's project" do
  let(:other_user) { create(:user) }
  let!(:other_project) { create(:project, user_id: other_user.id) }
  let(:project_id) { other_project.id }

  it 'returns status code 404' do
    expect(response).to have_http_status(404)
  end

  it 'returns a not found message' do
    expect(response.body).to match(/Couldn't find Project/)
  end
end
