class Game < ActiveRecord::Base

  # Association
  has_many :users, :through => :playings
  has_many :playings, :order => 'play_order asc' 
  has_many :propositions
  
  accepts_nested_attributes_for :playings, :allow_destroy => true

  
  def self::countries
    %w{Austria Dutch England France Prussia Russia Spain}
  end
  
  def current_proposition
      propositions.find_or_create_by_war_and_opened( :war => war, :opened => true, 
        :game_id => id, :round => round, :positionA => "", :positionB => "", :amount => nil)
  end
  
  def concluded_propositions(for_war)
    propositions.where(:war => for_war, :opened => false).order('round')
  end
  
  def current_countries
    playings.map {|playing| playing.country}
  end
  
  def available_countries
    current_countries - (concluded_propositions(war).map {|prop| [prop.positionA, prop.positionB]}.flatten)
  end
  
  def propositions_tabled(for_war)
    if concluded_propositions(for_war).empty?
      return [[nil, nil, nil, nil], [nil,nil,nil,nil]]
    else
      concluded_propositions(for_war).map {|prop| prop.positionA}.in_groups_of(4) + concluded_propositions(for_war).map {|prop| prop.positionB}.in_groups_of(4)
    end
  end
  
  def current_player
    playings.first
  end
  
  def close_proposition
    current_proposition.update_attribute(:opened, false)
    reset_pass
    if available_countries.count == 0
      # Find last player and set it the first player for next war
      prop = concluded_propositions(war).last
      last_player = prop.positionB.empty? ? prop.positionA : prop.positionB
      next_player = playings.where(:country => last_player).first
      players = playings.where("play_order < #{next_player.play_order}").all

      players.each do |player|
        player.increment!(:play_order, 7)      
      end
      
      increment! :war
      update_attribute(:round, 1)
    else
      increment! :round
      playings.first.increment!(:play_order, 7)
    end 
  end
  
  def reset_pass
    playings.each do |player|
      player.update_attribute(:pass, false)
    end
  end
end
