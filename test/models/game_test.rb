require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test 'by default #can_throw? is true' do
    game = Game.new
    game.can_throw?.must_equal true
  end

  test 'Database Check: Items are getting correctly saved in database' do
    game = Game.new
    Throw.create({"position" => 1, "pins_down" => 5})
    Throw.create({"position" => 2, "pins_down" => 4})
    Throw.count.must_equal 2
    Throw.where('position = 1')[0].pins_down.must_equal 5
    Throw.where('position = 2')[0].pins_down.must_equal 4   
  end

  test '#input_score method should set value of #accept_flag to false when data is invalid' do
    game = Game.new
    Throw.create({"position" => 1, "pins_down" => 5})
    params = {:throw => {:pins_down => "6"}}
    throw_obj, accept_flag = game.input_score params
    accept_flag.must_equal false
  end

  test '#input_score method should create the throw object with correct values' do
    game = Game.new
    Throw.create({"position" => 1, "pins_down" => 5})
    Throw.create({"position" => 2, "pins_down" => 5})
    Throw.create({"position" => 3, "pins_down" => 5})
    Throw.create({"position" => 4, "pins_down" => 5})
    params = {:throw => {:pins_down => "6"}}
    throw_obj, accept_flag = game.input_score params
    accept_flag.must_equal true
    throw_obj.pins_down.must_equal 6
    throw_obj.position.must_equal 5
  end

  test "Frame Check 1: #calculate_frames method should update frames values correctly" do
    game = Game.new
    Throw.create({"position" => 1, "pins_down" => 10})
    Throw.create({"position" => 2, "pins_down" => 7})
    Throw.create({"position" => 3, "pins_down" => 3})
    Throw.create({"position" => 4, "pins_down" => 9})
    output_frame = game.calculate_frames(Throw.all)
    output_frame[0].must_equal 20
    output_frame[1].must_equal 19
  end


  test "Complete Frame Check 1: Compute the output of the frame value" do
    game = Game.new
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
    output_frame = game.calculate_frames(Throw.all)
    output_frame.must_equal [20,19,9,8,14,8,15,5,19,9]
    game.can_throw?.must_equal false
  end

  test "Complete Frame Check 2: Compute the output of the frame value" do
    game = Game.new
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
    Throw.create({"position" => 17, "pins_down" => 3})
    Throw.create({"position" => 17, "pins_down" => 4})
    output_frame = game.calculate_frames(Throw.all)
    output_frame.must_equal [20,19,9,8,14,8,15,5,20,14]
    game.can_throw?.must_equal false
  end

end 