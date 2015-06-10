class Employee::MyReferralsController < Poodle::AdminController

  skip_before_filter :require_admin

  def new
    @my_referral = MyReferral.new
    super
  end

  def create
    @my_referral = MyReferral.new(permitted_params)

    if @my_referral.save
      flash[:success] = "Successfully saved the data."
      redirect_to employee_my_referrals_path
    else
      error = "#{@my_referral.errors.full_messages}. #{@referral.errors.full_messages}"
      flash[:error] = "The email/phone is already registered with us. Error Details! #{error}"
      redirect_to employee_my_referrals_path
    end
  end

  def edit
    @my_referral = MyReferral.find_by_id(params[:id])
  end

  def update
    @my_referral = MyReferral.find_by_id(params[:id])
    @my_referral.assign_attributes(permitted_params)

    if @my_referral.save && @referral.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def download
    @my_referral = MyReferral.find_by_id(params[:id])
    if ["production", "staging"].include?(Rails.env)
      redirect_to @my_referral.candidate.resume.url
    else
      send_file @my_referral.candidate.resume.path, :x_sendfile => true
    end
  end

  private

  def permitted_params
    params[:my_referral].permit(:name, :email, :phone, :current_city, :native_city, :year_of_passing, :resume, :experience, :course, :subject, :institution, :native_state, :current_state, :cummunication_address, :skills, :job, :event, :applicant_relation)
  end

  def default_collection_name
    "my_referrals"
  end

  def default_item_name
    "my_referral"
  end

  def default_class
    MyReferral
  end

  def set_navs
    set_nav("employee/my_referrals")
    set_title("My Referrals | Q-Careers")
  end

end
