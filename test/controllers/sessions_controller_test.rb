require 'test_helper'
class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "login and browse site" do
    # login via https

	get_via_redirect "/sessions/new", login: users(:one).login
    	assert_response :success
	assert_equal "/reservations/new", path
	

 

end
end
