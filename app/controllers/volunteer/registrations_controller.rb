class Volunteer::RegistrationsController < Poodle::AdminController

  before_filter :require_volunteer
  skip_before_filter :require_admin
  before_filter :get_event

  def new
    @candidate = Candidate.new
    super
  end

  def search
    @relation = @event.career_interests.joins(:candidate).where("")
    if params[:query]
      @query = params[:query].strip
      @relation = @relation.search(@query) if !@query.blank?
    end
    @registrations = @relation.order("created_at desc").page(@current_page).per(@per_page)
  end

  def create
    @candidate = Candidate.new(candidate_params)
    # FIXME - Params are passed now some odd way.
    @candidate.year_of_passing = params[:candidate][:candidate][:registration][:year_of_passing]
    @registration = CareerInterest.new(event: @event, candidate: @candidate)
    if @candidate.save && @registration.save
      begin
        RegistrationsMailer.registration_desk(@registration).deliver_now
        rescue
      end
      flash[:success] = "Successfully Registered!"
    else
      flash[:error] = "Registration failed!"
      render "new"
    end
  end

  def edit
    @registration = CareerInterest.find_by_id(params[:id])
    @candidate = @registration.candidate
  end

  def update
    @registration = CareerInterest.find_by_id(params[:id])
    @candidate = @registration.candidate

    @candidate.assign_attributes(candidate_params)
    # FIXME - Params are passed now some odd way.
    @candidate.year_of_passing = params[:candidate][:candidate][:registration][:year_of_passing]

    @candidate.save && @registration.save
  end

  def download
    @registration = CareerInterest.find_by_id(params[:id])
    if ["production", "staging"].include?(Rails.env)
      redirect_to @registration.candidate.resume.url
    else
      send_file @registration.candidate.resume.path, :x_sendfile => true
    end
  end

  def mark_as_reported
    @registration = CareerInterest.find_by_id(params[:id])
    @candidate = @registration.candidate
    @registration.report!
  end

  def mark_as_not_reported
    @registration = CareerInterest.find_by_id(params[:id])
    @candidate = @registration.candidate
    @registration.cancel_report!
  end

  private

  def get_event
    @event = Event.find_by_id(params[:event_id])
  end

  def prepare_filters
    @filters = {}
    @filters[:year_of_passing] = params[:year_of_passing] unless params[:year_of_passing].blank?
    @filters[:current_city] = params[:current_city] unless params[:current_city].blank?
    @filters[:native_city] = params[:native_city] unless params[:native_city].blank?
  end

  def prepare_query
    prepare_filters
    @relation = @event.registrations.joins(:candidate).where("")
    if params[:query]
      @query = params[:query].strip
      @relation = @relation.search(@query) if !@query.blank?
    end
    @relation = @relation.where("candidates.year_of_passing = ?", @filters[:year_of_passing]) if @filters[:year_of_passing]
    @relation = @relation.where("candidates.current_city = ?", @filters[:current_city]) if @filters[:current_city]
    @relation = @relation.where("candidates.native_city = ?", @filters[:native_city]) if @filters[:native_city]
  end

  def candidate_params
    params[:candidate].permit(:name, :email, :phone, :current_city, :native_city, :year_of_passing, :resume )
  end

  def default_collection_name
    "registrations"
  end

  def default_item_name
    "registration"
  end

  def default_class
    CareerInterest
  end

  def permitted_params
    params[:career_interest].permit(:name, :slug, :date, :venue ,:description)
  end

  def set_navs
    set_nav("volunteer/registrations")
    set_title("Registrations | Q-Careers")
  end

end
