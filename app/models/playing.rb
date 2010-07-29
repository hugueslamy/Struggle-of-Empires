class Playing < ActiveRecord::Base

  # Associations
  belongs_to :user
  belongs_to :game
  
  # Callback
  after_update :check_all_pass
  
  def check_all_pass
    if pass_was == false
      if game.playings.count(:conditions => {:pass => true}) == game.playings.count
        game.close_proposition
      end
    end
  end
  
  def pass_player
    logger.debug self.inspect
    increment!(:play_order, 7)
    update_attribute(:pass, true)
  end  

 
end
