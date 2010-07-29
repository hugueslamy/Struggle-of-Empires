module GamesHelper
  def country_available?(country)
    @game.available_countries.member?(country)
  end
  
  def country_shown?(country)
    @game.current_proposition.positionA != country && @game.current_proposition.positionB != country
  end
  
  def get_alliance_image (country)
    unless country.nil?
      image_tag country.downcase + '.gif', :title => country, :alt => country
    end
  end
end
