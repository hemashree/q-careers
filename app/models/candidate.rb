class Candidate < ActiveRecord::Base

  # Associations
  has_many :career_interests
  has_many :events, through: :career_interests

  # Constants
  COUNTRY_LIST = ["India", "United States", "United Arab Emirates", "Costa Rica"]

  # Validations
  extend PoodleValidators

  validate_string :name, mandatory: true
  validate_email :email, uniqueness: true
  validate_string :phone, mandatory: true, min_length: 12, max_length: 12, format: /[0-9]{3}[-][0-9]{3}[-][0-9]{4}/, uniqueness: true

  validate_string :current_city, mandatory: true, max_length: 128, format: /.*/i
  validate_string :native_city, mandatory: true, max_length: 128, format: /.*/i
  validate_string :current_organization, mandatory: true if :candidate_type_validate == false
  validate_string :current_designation, mandatory: true if :candidate_type_validate == false
  validate_string :course, mandatory: true if :candidate_type_validate == true
  validate_string :subject, mandatory: true if :candidate_type_validate == true 
  validate_string :institution, mandatory: true if :candidate_type_validate == true

  # validate_string :year_of_passing, inclusion: %w("2009" "2010" "2011" "2012" "2013" "2014" "2015")
  # validates :resume, presence: true

  # File Uploader Method Hook
  mount_uploader :resume, ResumeUploader

  # return an active record relation object with the search query in its where clause
  # Return the ActiveRecord::Relation object
  # == Examples
  #   >>> candidate.search(query)
  #   => ActiveRecord::Relation object
  scope :search, lambda {|query| where("LOWER(candidates.name) LIKE LOWER('%#{query}%') OR LOWER(candidates.email) LIKE LOWER('%#{query}%') OR LOWER(candidates.skills) LIKE LOWER('%#{query}%') OR LOWER(candidates.current_city) LIKE LOWER('%#{query}%') OR LOWER(candidates.native_city) LIKE LOWER('%#{query}%') OR LOWER(candidates.phone) LIKE LOWER('%#{query}%')")}

  # Instance Methods
  # ----------------

  # * Return the first letters of first name and last name
  # == Examples
  #   >>> candidate = Candidate.new(name: "Anjan Gowda")
  #   >>> candidate.namify
  #   => "AG"

  def candidate_type_validate
    return self.candidate_type
  end

  def namify
    self.name.split(" ").map{|x| x.first.capitalize}[0..1].join("")
  end

  # * Return address which includes city, state & country
  # == Examples
  #   >>> candidate.display_address(type)
  #   => "Mysore, Karnataka, India"
  def display_address(type)
    [self.send("#{type}_city"), self.send("#{type}_state")].compact.uniq.join(", ")
    #address_list << send.("#{type}_city") unless send.("#{type}_city").blank?
    #address_list << send.("#{type}_state") unless send.("#{type}_state").blank?
    #address_list << send.("#{type}_country") unless send.("#{type}_country").blank?
    #address_list.join(", ")
  end

  def display_current_address
    display_address(:current)
  end

  def display_native_address
    display_address(:native)
  end

end
