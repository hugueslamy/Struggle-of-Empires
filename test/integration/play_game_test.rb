require 'test_helper'

class PlayGameTest < ActionController::IntegrationTest
  fixtures :games, :playings, :users
  
  setup do
    @game = games(:game_3)
    User.all.each do |user|
      user.password = 'banane'
      user.password_confirmation = 'banane'
      user.save!
    end
  end

  def login(user)
    post "/users/sign_in", :user => {:email => users(user).email, :password => 'banane'}
  end
  
  def logout
    get "/users/sign_out"
  end
  
  def pass_player(user, player)
    login(user)
    proposition = @game.current_proposition
    put_via_redirect proposition_path(proposition.id), {:proposition => {:positionA => '', :positionB => '',
      :playing_id => playings(player).id, :amount => '0'}, :commit => 'Pass'}
    logout
  end
  
  test "Play Game" do
    get "/"
    assert_redirected_to "/users/sign_in"
    
    login(:user_5)
    assert_redirected_to '/', flash[:alert]
    
    get "/games/", @game.to_param
    assert_response :success
    assert_not_nil assigns(:games)
    
    # Round 1
    proposition = @game.current_proposition
    put_via_redirect proposition_path(proposition.id), {:proposition => {:positionA => 'France', :positionB => 'Russia',
      :playing_id => playings(:player_15).id, :amount => '0'}, :commit => 'Submit'}
    assert_response :success
      
    proposition.reload
    assert proposition.positionA == 'France'
    
    pass_player(:user_4, :player_14)
    pass_player(:user_3, :player_13)
    pass_player(:user_2, :player_12)
    pass_player(:user_1, :player_11)
    
    @game.reload
    assert @game.round == 2, @game.round.to_s
    assert playings(:player_14) === @game.current_player, @game.current_player.inspect
    
    #Round 2
    login (:user_4)
    
    proposition = @game.current_proposition
    put_via_redirect proposition_path(proposition.id), {:proposition => {:positionA => 'Austria', :positionB => 'Spain',
      :playing_id => playings(:player_14).id, :amount => '0'}, :commit => 'Submit'}
    
    pass_player(:user_3, :player_13)
    pass_player(:user_2, :player_12)
    pass_player(:user_1, :player_11)
    pass_player(:user_5, :player_15)
    
    @game.reload
    assert @game.round == 3, @game.round.to_s
    assert playings(:player_13) === @game.current_player, @game.current_player.inspect
    
    # Round 3
    login (:user_3)
    
    proposition = @game.current_proposition
    put_via_redirect proposition_path(proposition.id), {:proposition => {:positionA => 'England', :positionB => '',
      :playing_id => playings(:player_13).id, :amount => '0'}, :commit => 'Submit'}
    
    pass_player(:user_2, :player_12)
    pass_player(:user_1, :player_11)
    pass_player(:user_5, :player_15)
    pass_player(:user_4, :player_14)
    
    @game.reload
    assert @game.round == 1, @game.round.to_s
    assert playings(:player_13) === @game.current_player, @game.current_player.inspect
    
  end
  
  
end
