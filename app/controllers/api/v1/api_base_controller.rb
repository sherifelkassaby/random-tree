class Api::V1::ApiBaseController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def response_success(success_message = nil, attributes = {})
    { success: true, msg: success_message }.merge(attributes)
  end

  def response_fail(error_message = nil, attributes = {})
    { success: false, msg: error_message }.merge(attributes)
  end
end
