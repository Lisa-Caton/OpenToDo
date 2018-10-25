class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  USERNAME, PASSWORD = 'boss', 'freak'
  before_action :authenticated?

  private
  #using this private method - other API controllers will be able to ensure users are authorized:
  def authenticated?
    authenticate_or_request_with_http_basic {|username, password| User.where( username: username, password: password).present? }
  end
end
