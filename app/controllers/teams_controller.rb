class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    @teams = Team.all
  end

  def show
  end

  def new
    @team = Team.new
  end

  def edit
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      redirect_to @team, notice: 'Team was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @team.update(team_params)
      redirect_to @team, notice: 'Team was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    #wraz z usunieciem druzyny usuwamy jej historie meczy -> kaskadowe usuwanie
    #Match.where(:team_one_id => @team.id).destroy_all
    #Match.where(:team_two_id => @team.id).destroy_all
    @team.destroy
    redirect_to teams_path, notice: 'Team was successfully deleted.'
  end

  private

    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.require(:team).permit(:name, :date_of_founding)
    end
end
