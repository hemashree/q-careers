class CareerInterest < ActiveRecord::Base

  # Associations
  belongs_to :candidate
  belongs_to :event
  belongs_to :referrer, class_name: "QAuthRubyClient::User"

  # Validations
  validates :candidate, presence: true

  # Callbacks
  before_save :check_source_and_referrer

  # Source can be the following
  # registration_desk
  # candidate
  # employee_referral

  # Class Methods

  # return an active record relation object with the search query in its where clause
  # Return the ActiveRecord::Relation object
  # == Examples
  #   >>> candidate_search.search(query)
  #   => ActiveRecord::Relation object
  scope :search, lambda {|query| where("LOWER(candidates.name) LIKE LOWER('%#{query}%') OR LOWER(candidates.email) LIKE LOWER('%#{query}%') OR LOWER(candidates.skills) LIKE LOWER('%#{query}%') OR LOWER(candidates.current_city) LIKE LOWER('%#{query}%') OR LOWER(candidates.native_city) LIKE LOWER('%#{query}%') OR LOWER(candidates.phone) LIKE LOWER('%#{query}%')")}

  def self.fetch(event, candidate)
    CareerInterest.where("event_id = ? AND candidate_id = ?", event.id, candidate.id).first || CareerInterest.new(event: event, candidate: candidate)
  end

  # Instance Methods

  def application_id
    source_code = source.split("_").map{|x| x[0].capitalize}.join("")
    "#{event.id}-#{source_code}#{100+id}"
  end

  def confirm!
    update_attributes(confirmed: true, confirmed_at: Time.now)
  end

  def report!
    update_attributes(reported: true, reported_at: Time.now)
  end

  def cancel_report!
    update_attributes(reported: false, reported_at: nil)
  end

  def applicant_name
    candidate.name
  end

  def change_referrer(user)
    self.referrer = user
    self.save
  end

  def self.to_csv(career_interests, options = {})
    CSV.generate(options) do |csv|
      csv << Candidate.column_names
      career_interests.each do |career_interest|
        csv << career_interest.candidate.attributes.values_at(*Candidate.column_names)
      end
    end
  end

  private
  def check_source_and_referrer
    self.source = :employee_referral if referrer.present?
  end
end