class QcareerConfiguration < ActiveRecord::Base
	
	# Validations
	extend PoodleValidators
	validate_string :name, mandatory: true, min_length: 8, max_length: 32, format: /\A[A-Z\_]*\z/, uniqueness: true
	validate_string :value, mandatory: true, min_length: 3, max_length: 256, format: /.*/i
	validate_string :description, mandatory: true, min_length: 3, max_length: 1024, format: /.*/i

	# Callbacks
	#before_validation :upcase_name, if: Proc.new { attribute(:value).present? }

	#def upcase_name
	#	self.name.upcase!
	#end

	# Class Methods
  # ----------------

	def self.homepage_event
		event = nil
		conf = find_by_name("HOMEPAGE_EVENT")
		event = Event.where("status != 'over' AND slug = ?", conf.value).first if conf
		event
	end
end
