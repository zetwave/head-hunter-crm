class MissionsController < ApplicationController
  #  id                 :integer          not null, primary key
  #  name               :string
  #  reward             :float
  #  paid_amount        :float
  #  min_salary         :float
  #  max_salary         :float
  #  criteria           :string
  #  signed             :boolean
  #  is_done            :boolean
  #  created_at         :datetime         not null
  #  updated_at         :datetime         not null
  #  person_id          :integer
  #  company_id         :integer
  #  whished_start_date :date
  before_action :logged_in_user
  before_action :find_mission, only: [:edit, :show, :update, :destroy]

  def new
    @mission = Mission.new
    @mission.status = :opportunity
    @mission.paid_amount = 0
    @forwhom = params[:person_id] || 0
    @mission.user_id = current_user.id
  end

  def index
    condition = params[:q].nil? || params[:q]['status_eq'].nil?
    @status_selected = condition ? ' ' : params[:q]['status_eq']
    @q = Mission.ransack(params[:q])
    @missions = @q.result.includes(:company, :person).page(pointed_page)
    authorize @missions
  end

  def edit
    @person = Person.find(@mission.person_id)
    @company = Company.find(@mission.company_id)
  end

  def show
    @passed_comactions = Comaction.unscoped.older_than(0).mission_list(@mission)
    @future_comactions = Comaction.unscoped.newer_than(0).mission_list(@mission)
  end

  def create
    @person = Person.find(mission_params[:person_id])
    @company = Company.find(mission_params[:company_id])

    @mission = @person.missions.build(mission_params)
    authorize @mission
    @mission = further_init(@mission)

    if !@person.nil? && !@company.nil? && @mission.save
      flash[:info] = I18n.t('mission.saved')
      redirect_to person_path(@person)
    else
      flash[:danger] = I18n.t('mission.not_added')
      render :new
    end
  end

  def update
    @mission.is_done = [:mission_billed, :mission_payed].include?(mission_params[:status])
    @mission.signed  = [:contract_signed, :mission_billed, :mission_payed].include?(mission_params[:status])

    if @mission.update_attributes(mission_params)
      flash[:success] = I18n.t('mission.updated')
      redirect_to @mission
    else
      flash[:danger] = I18n.t('mission.unupdated')
      render 'edit'
    end
  end

  def destroy
    @mission.destroy
    flash[:success] = I18n.t('mission.destroyed')
    redirect_to missions_path
  end

  def add_ext
    model = params['model'].to_s || 'person'
    dest = 'new_' + model + '_path'
    if params[:id].nil?
      set_next_url new_mission_path
    else
      set_next_url edit_mission_path(params[:id])
    end
    redirect_to send dest
  end

  def further_init(mission)
    mission.status = :opportunity
    mission.is_done = false
    mission.signed = false
    mission.user_id = current_user.id
    mission
  end

  # ---------------
  private
  # ---------------
    def mission_params
      params.require(:mission).permit(
        :name,
        :reward,
        :paid_amount,
        :min_salary,
        :max_salary,
        :criteria,
        :status,
        :person_id,
        :company_id,
        :whished_start_date,
        :user_id)
    end

    def find_mission
      @mission = Mission.find(params[:id])
      authorize @mission
    end
end
