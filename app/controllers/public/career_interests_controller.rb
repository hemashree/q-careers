class Public::CareerInterestsController < Public::BaseController

  before_filter :get_details

  def show
  end

  def create
    @career_interest = CareerInterest.new
    @career_interest.assign_attributes(permitted_params)
    @career_interest.source = :registration_desk
    save_resource(@career_interest)
  end

   def edit
    @registration = CareerInterest.find_by_id(params[:id])
    @candidate = @registration.candidate
  end

  def update
    @registration = CareerInterest.find_by_id(params[:id])
    @candidate = @registration.candidate

    @candidate.resume = params[:candidate][:resume]

    if @candidate.save && @registration.save
      flash[:success] = "Resume has been uploaded successfully!"
      redirect_to root_path
    else
      flash[:error] = "Failed to upload your resume!"
      render "edit"
    end
  end

  def confirm
    unless @career_interest.confirm!
      flash[:error] = "Unknown error while confirming"
    end
    redirect_to public_event_career_interest_path(event_id: @event.slug, id: @career_interest.id)
  end

  private

  def get_details
    @event = Event.find_by_slug(params[:event_id]) || Event.find_by_id(params[:event_id])
    @career_interest = CareerInterest.find_by_id(params[:id])
    @fresher = @career_interest.candidate
  end

  def set_navs
    set_nav("public/events")
  end

end