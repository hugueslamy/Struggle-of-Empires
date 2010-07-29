class PropositionsController < ApplicationController
  before_filter :authenticate_user!
  
  # PUT /propositions/1
  # PUT /propositions/1.xml
  def update
    @proposition = Proposition.find(params[:id])
    @player = Playing.find(params[:proposition][:playing_id].to_i) 

    redirect_to(@proposition.game, :notice => 'it\'s not your turn to play') and return unless @player === @proposition.game.current_player

    if params[:commit] == 'Pass'
      @player.pass_player
      redirect_to(@proposition.game, :notice => 'You just pass on this bid.') and return 
    end

    respond_to do |format|
      if @proposition.update_attributes(params[:proposition])
        @proposition.game.reset_pass
        @player.pass_player
        
        format.html { redirect_to(@proposition.game, :notice => 'Proposition was successfully updated.') }
        format.xml  { head :ok }
      else
        flash[:alert] = @proposition.errors.full_messages
        format.html { redirect_to(@proposition.game) }
        format.xml  { render :xml => @proposition.errors, :status => :unprocessable_entity }
      end
    end
  end
end
