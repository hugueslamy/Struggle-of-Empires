class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
   # :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, 
         :validatable, :token_authenticatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation
  
  # Associations
  has_many :games, :through => :playings
  has_many :playings
end
