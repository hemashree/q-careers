class Fresher < Candidate

  # Constants
  CURRENT_YEAR = Date.today.year
  YEAR_OF_PASSING_LIST = (CURRENT_YEAR-6..CURRENT_YEAR).to_a

  # Validations
  validates :year_of_passing, :inclusion => {:in => YEAR_OF_PASSING_LIST, :message => "Please select from the list" }

  # Class Methods
  # -------------

  # * Return fresher candidate which matches the email else will build a new one with the passed email
  # == Examples
  #   >>> Fresher.fetch("some@email.com")
  #   => <Fresher Active Record Object>
  def self.fetch(params)
    fresher = Fresher.find_by_email(params[:email]) if params[:email]
    fresher = Fresher.new(params) unless fresher
    fresher
  end

end
