class Proposition < ActiveRecord::Base
  belongs_to :playing
  belongs_to :game
  
  validate :on => :update do |proposition| 
    proposition.check_countries
  end
  
  validates_numericality_of :amount, :on => :update, :only_integer => true, :greater_than_or_equal_to => 0
  
  def check_countries
    errors[:base] << ("Please select some countries") and return if positionA.empty? and positionB.empty?
    errors[:base] << ("Two positions can't be the same") and return if positionA == positionB
    unless amount_was.nil?
      errors[:base] << ("Amount must be superior than the previous bid of: " + amount_was.to_s) and return if amount <= amount_was
    end
    errors[:base] << ("Country not available A") and return unless positionA.empty? || game.available_countries.member?(positionA)
    errors[:base] << ("Country not available B") and return unless positionB.empty? || game.available_countries.member?(positionB)
    
    if positionB.empty?
      errors[:base] << ("Select two countries A") unless !positionA.empty? && ((game.available_countries - [positionA]) == [])    
    end
    
    if positionA.empty?
      errors[:base] << ("Select two countries B") unless !positionB.empty? && ((game.available_countries - [positionB]) == [])
    end
  end
  
end
