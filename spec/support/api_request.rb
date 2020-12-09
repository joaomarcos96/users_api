module APIRequest
  def json_body
    JSON.parse(response.body)
  rescue
    return {}
  end

  def auth_header(user = nil, merge_with: {})
    user ||= create(:user)
    auth = user.create_new_auth_token
    header = auth.merge({ 'Content-Type' => 'application/json', 'Accept' => 'application/json' })
    header.merge merge_with
  end
end

RSpec.configure do |config|
  config.include APIRequest, type: :request
end
