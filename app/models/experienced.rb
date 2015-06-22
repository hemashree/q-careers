class Experienced < Candidate

  # Constants
  CURRENT_YEAR = Date.today.year
  YEAR_OF_PASSING_LIST = (CURRENT_YEAR-50..CURRENT_YEAR).to_a
  YEARS_LIST = (1..50).to_a

  # Validations
  validates :year_of_passing, :inclusion => {:in => YEAR_OF_PASSING_LIST, :message => "Please select from the list" }
  validates :experience_in_years, :inclusion => {:in => YEARS_LIST, :message => "Please select from the list" }

  # Class Methods
  # -------------

  # * Return experienced candidate which matches the email else will build a new one with the passed email
  # == Examples
  #   >>> Experienced.fetch("some@email.com")
  #   => <Experienced Active Record Object>
  def self.fetch(params)
    experienced = Experienced.find_by_email(params[:email]) if params[:email]
    experienced = Experienced.new(params) unless experienced
    experienced
  end

end
