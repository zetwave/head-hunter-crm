class JobsController < ApplicationController
  before_action :logged_in_user
  before_action :get_job,   only: [:edit, :show, :update, :destroy]

  def new
    @job = Job.new
  end
  #-----------------
  def index
    @jobs = Job.paginate(page: params[:page])
    authorize @jobs unless @jobs.count == 0
  end
  #-----------------
  def edit
    @person = Person.find(@job.person_id)
    authorize @job
  end
  #-----------------
  # def show
  # end
  #-----------------
  def create
    @person = Person.find(job_params[:person_id])

    @job = @person.jobs.build(job_params)
    @job.end_date = nil if (@job.no_end?)
    authorize @job

    if @job.save
      @company = Company.find(@job.company_id)
      @job.company = @company unless @company.nil?
      message = "#{@job.person.firstname}" + I18n.t("job.new_saved")
      # if @job.person.double_jobs
      #   flash[:warning] = message + ' (ce profil a plusieurs emplois en parallèle)'
      # else
        flash[:info] = message
      # end
    else
      flash[:danger] = I18n.t("job.danger_message")
    end

    redirect_to person_path(@person.id)
  end
  #-----------------
  def update
    authorize @job
    if @job.update_attributes(job_params)
      flash[:success] = 'Emploi mis à jour'
      @person = Person.find(@job.person_id)
      redirect_to @person
    else
      flash[:danger] = I18n.t("job.unpupdated")
      render 'edit'
    end
  end
  #-----------------
  def destroy
    authorize @job
    person_id = @job.person_id
    @job.destroy
    flash[:success] = I18n.t("job.canceled")
    redirect_to person_path(person_id)
  end
  #-----------------

  #---------------
  private
  #---------------
    def job_params
      params.require(:job).permit(
        :job_title,
        :salary,
        :start_date,
        :end_date,
        :jj_job,
        :company_id,
        :person_id,
        :no_end)
    end

    def get_job
      @job = Job.find(params[:id])
    end
end
