require 'test_helper'

class PropositionTest < ActiveSupport::TestCase
  test "Empty" do
    prop = games(:game_1).current_proposition
    prop.positionA = ""
    prop.positionB = ""
    prop.check_countries
    assert prop.errors.count == 1, prop.errors.full_messages.to_s
  end
  
  test "Same Country" do
    prop = games(:game_1).current_proposition
    prop.positionA = "Russia"
    prop.positionB = "Russia"
    prop.check_countries
    assert prop.errors.count == 1, prop.errors.full_messages.to_s
  end

  test "Inferior Bid" do
    prop = games(:game_1).current_proposition
    prop.positionA = "England"
    prop.positionB = ""
    prop.amount = 3
    prop.check_countries
    assert prop.errors.count == 1, prop.errors.full_messages.to_s
  end

  test "Country A not available" do
    prop = games(:game_1).current_proposition
    prop.positionA = "Dutch"
    prop.positionB = "England"
    prop.amount = 5
    prop.check_countries
    assert prop.errors.count == 1, prop.errors.full_messages.to_s
  end

  test "Country B not available" do
    prop = games(:game_1).current_proposition
    prop.positionA = "England"
    prop.positionB = "Dutch"
    prop.amount = 5
    prop.check_countries
    assert prop.errors.count == 1, prop.errors.full_messages.to_s
  end

  test "Country A not available but in game" do
    prop = games(:game_1).current_proposition
    prop.positionA = "Russia"
    prop.positionB = "England"
    prop.amount = 5
    prop.check_countries
    assert prop.errors.count == 1, prop.errors.full_messages.to_s
  end

  test "Country B not available but in game" do
    prop = games(:game_1).current_proposition
    prop.positionA = "Russia"
    prop.positionB = "England"
    prop.amount = 5
    prop.check_countries
    assert prop.errors.count == 1, prop.errors.full_messages.to_s
  end
  
  test "A selected and still remains" do
    prop = games(:game_1).current_proposition
    prop.positionA = "England"
    prop.positionB = ""
    prop.amount = 5
    prop.check_countries
    assert prop.errors.count == 0, prop.errors.full_messages.to_s
  end

  test "B selected and still remains" do
    prop = games(:game_1).current_proposition
    prop.positionA = ""
    prop.positionB = "England"
    prop.amount = 5
    prop.check_countries
    assert prop.errors.count == 0, prop.errors.full_messages.to_s
  end
  
  test "Game_2 2 countries selected" do
    prop = games(:game_2).current_proposition
    prop.positionA = "France"
    prop.positionB = "England"
    prop.amount = 1
    prop.check_countries
    assert prop.errors.count == 0, prop.errors.full_messages.to_s
  end

  test "Game_2 2 countries selected not available" do
    prop = games(:game_2).current_proposition
    prop.positionA = "Dutch"
    prop.positionB = "England"
    prop.amount = 1
    prop.check_countries
    assert prop.errors.count == 1, prop.errors.full_messages.to_s
  end
  
  test "Game_2 1 countries selected " do
    prop = games(:game_2).current_proposition
    prop.positionA = ""
    prop.positionB = "England"
    prop.amount = 1
    prop.check_countries
    assert prop.errors.count == 1, prop.errors.full_messages.to_s
  end
   
  
  
  
end
