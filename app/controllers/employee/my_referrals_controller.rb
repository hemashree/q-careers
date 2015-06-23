class Employee::MyReferralsController < Poodle::AdminController

  skip_before_filter :require_admin
  
  def new
    @candidate = Candidate.new
    super
  end

  def create
    @candidate = Candidate.new(permitted_params)
    @candidate.year_of_passing = params[:candidate][:my_referral][:year_of_passing]

    @referral = CareerInterest.new(candidate: @candidate, referrer: current_user)
    if @candidate.save && @referral.save
      flash[:success] = "Successfully saved the data."
      begin
        RegistrationsMailer.employee_referral(@referral).deliver_now
      rescue
      end
      redirect_to employee_my_referrals_path
    else
      error = "#{@candidate.errors.full_messages}. #{@referral.errors.full_messages}"
      flash[:error] = "The email/phone is already registered with us. Error Details! #{error}"
      redirect_to employee_my_referrals_path
    end
  end

  def edit
    @referral = CareerInterest.find_by_id(params[:id])
    @candidate = @referral.candidate
  end

  def update
    @referral = CareerInterest.find_by_id(params[:referral_id])
    @candidate = @referral.candidate
    @referral.referrer = current_user
    @candidate.assign_attributes(permitted_params)

    # FIXME - Params are passed now some odd way.
    @candidate.year_of_passing = params[:candidate][:my_referral][:year_of_passing]

    if @candidate.save && @referral.save
      redirect_to employee_my_referrals_path
    else
      redirect_to employee_my_referrals_path
    end
  end

  def download
    @referral = CareerInterest.find_by_id(params[:id])
    if ["production", "staging"].include?(Rails.env)
      redirect_to @referral.candidate.resume.url
    else
      send_file @referral.candidate.resume.path, :x_sendfile => true
    end
  end

  private

  def permitted_params
    params[:candidate].permit(:name, :email, :phone, :current_city, :native_city, :year_of_passing, :resume,:candidate_type,:course,:subject,:institution,:current_organization,:current_designation,:skills,:current_state,:native_state)
  end

  def default_collection_name
    "referrals"
  end

  def default_item_name
    "referral"
  end

  def default_class
    CareerInterest
  end

  def set_navs
    set_nav("employee/my_referrals")
    set_title("My Referrals | Q-Careers")
  end

end
