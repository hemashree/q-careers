class Admin::CareerInterestsController < Poodle::AdminController

	before_filter :require_admin


	def export_candidate
		@career_interests = CareerInterest.where("event_id = ?", params[:id]).all
		respond_to do |format|
			format.html
			format.csv { render text: @career_interests.to_csv(@career_interests) }
			format.xls { send_data @career_interests.to_csv(@career_interests) }
		end
	end

end