class Candidate < ActiveRecord::Base

  # Validations
  extend PoodleValidators

  validate_string :name, mandatory: true
  validate_email :email, uniqueness: true
  validate_phone :phone,  phone_format: :indian

  validate_string :current_city, mandatory: true, max_length: 128, format: /.*/i
  validate_string :current_state, mandatory: true, max_length: 128, format: /.*/i
  validate_string :native_city, mandatory: true, max_length: 128, format: /.*/i
  validate_string :native_state, mandatory: true, max_length: 128, format: /.*/i

  # Associations
  has_many :career_interests
  has_many :events, through: :career_interests
  
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
  def namify
    self.name.split(" ").map{|x| x.first.capitalize}[0..1].join("")
  end

  # * Return address which includes city & state
  # == Examples
  #   >>> candidate.display_address(type)
  #   => "Mysore, Karnataka"
  def display_address(type)
    [self.send("#{type}_city"), self.send("#{type}_state")].compact.uniq.join(", ")
  end

  def display_current_address
    display_address(:current)
  end

  def display_native_address
    display_address(:native)
  end

end
