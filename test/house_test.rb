require "minitest/autorun"
require "minitest/pride"
require "./lib/house.rb"
require "./lib/room.rb"

class HouseTest < Minitest::Test
  def test_it_exists
    house = House.new("$400000", "123 sugar lane")

    assert_instance_of House, house
  end

  def test_can_get_attributes
    house = House.new("$400000", "123 sugar lane")

    assert_equal 400000, house.price
    assert_equal "123 sugar lane", house.address
    assert_equal [], house.rooms
  end

  def test_add_room_method
    house = House.new("$400000", "123 sugar lane")
    room1 = Room.new(:bedroom, 10, '13')
    room2 = Room.new(:bedroom, 11, '15')
    house.add_room(room1)

    assert_equal [room1], house.rooms

    house.add_room(room2)

    assert_equal [room1, room2], house.rooms
  end

  def test_house_above_market_average_method
    house = House.new("$400000", "123 sugar lane")
    house2 = House.new("$600000", "125 sugar lane")

    assert_equal false, house.above_market_average?
    assert_equal true, house2.above_market_average?
  end

  def test_rooms_from_category_method
    house = House.new("$400000", "123 sugar lane")
    room1 = Room.new(:bedroom, 10, '13')
    room2 = Room.new(:bedroom, 11, '15')
    room3 = Room.new(:living_room, 25, '15')
    room4 = Room.new(:basement, 30, '41')
    house.add_room(room1)
    house.add_room(room2)
    house.add_room(room3)
    house.add_room(room4)

    assert_equal [room1, room2], house.rooms_from_category(:bedroom)
    assert_equal [room3], house.rooms_from_category(:living_room)
  end

  def test_area_method
    house = House.new("$400000", "123 sugar lane")
    room1 = Room.new(:bedroom, 10, '13')
    room2 = Room.new(:bedroom, 11, '15')
    room3 = Room.new(:living_room, 25, '15')
    room4 = Room.new(:basement, 30, '41')
    house.add_room(room1)
    house.add_room(room2)
    house.add_room(room3)
    house.add_room(room4)

    assert_equal 1900, house.area
  end

  def test_details_method
    house = House.new("$400000", "123 sugar lane")
    room1 = Room.new(:bedroom, 10, '13')
    room2 = Room.new(:bedroom, 11, '15')
    room3 = Room.new(:living_room, 25, '15')
    room4 = Room.new(:basement, 30, '41')
    house.add_room(room1)
    house.add_room(room2)
    house.add_room(room3)
    house.add_room(room4)
    details = {"price"=>400000, "address"=>"123 sugar lane"}

    assert_equal details, house.details
  end

  def test_price_per_square_foot_method
    house = House.new("$400000", "123 sugar lane")
    room1 = Room.new(:bedroom, 10, '13')
    room2 = Room.new(:bedroom, 11, '15')
    room3 = Room.new(:living_room, 25, '15')
    room4 = Room.new(:basement, 30, '41')
    house.add_room(room1)
    house.add_room(room2)
    house.add_room(room3)
    house.add_room(room4)

    assert_equal 210.53, house.price_per_square_foot
  end

  def test_rooms_sorted_by_area
    house = House.new("$400000", "123 sugar lane")
    room1 = Room.new(:bedroom, 10, '13')
    room2 = Room.new(:bedroom, 11, '15')
    room3 = Room.new(:living_room, 25, '15')
    room4 = Room.new(:basement, 30, '41')
    house.add_room(room1)
    house.add_room(room2)
    house.add_room(room3)
    house.add_room(room4)

    assert_equal [room4, room3, room2, room1], house.rooms_sorted_by_area
  end

  def test_rooms_by_category_method
    house = House.new("$400000", "123 sugar lane")
    room1 = Room.new(:bedroom, 10, '13')
    room2 = Room.new(:bedroom, 11, '15')
    room3 = Room.new(:living_room, 25, '15')
    room4 = Room.new(:basement, 30, '41')
    house.add_room(room1)
    house.add_room(room2)
    house.add_room(room3)
    house.add_room(room4)
    list = {:bedroom=>[room1,room2], :living_room=>[room3], :basement=>[room4]}

    assert_equal list, house.rooms_by_category
  end
end
