class GamesController < ApplicationController
  before_filter :authenticate_user!

  # GET /games
  # GET /games.xml
  def index
    @games = current_user.games

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @games }
    end
  end

  # GET /games/1
  # GET /games/1.xml
  def show
    @game = current_user.games.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @game }
    end
  end

  # GET /games/new
  # GET /games/new.xml
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @game }
    end
  end

  # POST /games
  # POST /games.xml
  def create
    @game = current_user.games.new(params[:game])

    respond_to do |format|
      if @game.save
        fill_player_spot @game.id
        format.html { redirect_to(@game, :notice => 'Game was successfully created.') }
        format.xml  { render :xml => @game, :status => :created, :location => @game }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.xml
#  def update
#    @game = current_user.games.find(params[:id])

#    respond_to do |format|
#      if @game.update_attributes(params[:game])
#        format.html { redirect_to(@game, :notice => 'Game was successfully updated.') }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
#      end
#    end
#  end

  # DELETE /games/1
  # DELETE /games/1.xml
  def destroy
    unless current_user.id != 1
      redirect_to '/', :notice => 'You are not allowed to delete games.'
      return
    end
    @game = Games.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to(games_url) }
      format.xml  { head :ok }
    end
  end

  def fill_player_spot(game_id)
    play_order = 0
    Game.countries.shuffle.each do |country|
      unless (params[:playing][country]).empty?
        Playing.create(:user_id => params[:playing][country].to_i, :game_id => game_id, :country => country, :play_order => play_order)
        play_order += 1
      end
    end
  end  
end
