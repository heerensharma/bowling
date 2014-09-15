require 'test_helper'

class ThrowsControllerTest < ActionController::TestCase

	test "should get index and check values of instances variables are correctly set" do
		Throw.create({"position" => 1, "pins_down" => 10})
    Throw.create({"position" => 2, "pins_down" => 7})
    Throw.create({"position" => 3, "pins_down" => 3})
    Throw.create({"position" => 4, "pins_down" => 9})
    Throw.create({"position" => 5, "pins_down" => 0})
		get :index
		assert_response :success
    assert_template layout: "layouts/application"
    assigns(:can_throw).must_equal true
    assigns(:frames).must_equal [20,19,9,0,0,0,0,0,0,0]
    assigns(:throws).map {|throw_element| throw_element.pins_down}.must_equal [10,7,3,9,0]
	end

	test "check whether form submission is working correctly or not" do
		Throw.create({"position" => 1, "pins_down" => 10})
    Throw.create({"position" => 2, "pins_down" => 7})
    Throw.create({"position" => 3, "pins_down" => 3})
    Throw.create({"position" => 4, "pins_down" => 9})
    Throw.create({"position" => 5, "pins_down" => 0}) 
    post(:create, {:throw => {:pins_down => '4'}})
    assert_redirected_to throws_url
    Throw.count.must_equal 6
    Throw.last.position.must_equal 6
    Throw.last.pins_down.must_equal 4
	end

	test "should check whether accepted input constraints are working or not" do
		Throw.create({"position" => 1, "pins_down" => 10})
    Throw.create({"position" => 2, "pins_down" => 7})
    post(:create, {:throw => {:pins_down => '4'}})
    assert_redirected_to throws_url
    Throw.last.position.must_equal 2
    post(:create, {:throw => {:pins_down => '-1'}})
    Throw.last.position.must_equal 2
    post(:create, {:throw => {:pins_down => '12'}})
    Throw.last.position.must_equal 2
	end

	test "@can_throw variable should be false after all the trials within a game are over" do
		Throw.create({"position" => 1, "pins_down" => 10})
    Throw.create({"position" => 2, "pins_down" => 7})
    Throw.create({"position" => 3, "pins_down" => 3})
    Throw.create({"position" => 4, "pins_down" => 9})
    Throw.create({"position" => 5, "pins_down" => 0})
    Throw.create({"position" => 6, "pins_down" => 7})
    Throw.create({"position" => 7, "pins_down" => 1})
    Throw.create({"position" => 8, "pins_down" => 9})
    Throw.create({"position" => 9, "pins_down" => 1})
    Throw.create({"position" => 10, "pins_down" => 4})
    Throw.create({"position" => 11, "pins_down" => 4})
    Throw.create({"position" => 12, "pins_down" => 10})
    Throw.create({"position" => 13, "pins_down" => 0})
    Throw.create({"position" => 14, "pins_down" => 5})
    Throw.create({"position" => 15, "pins_down" => 10})
    Throw.create({"position" => 16, "pins_down" => 7})
    Throw.create({"position" => 17, "pins_down" => 2})
    get :index
    assigns(:can_throw).must_equal false
	end

	test "#destroy action occuring on clicking #New Game Start button is removing 
												all previous entries from Throw data table" do
		delete(:destroy)
		assert_redirected_to throws_url
		Throw.count.must_equal 0
	end

end