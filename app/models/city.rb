class City 
  include Neo4j::ActiveNode
  property :name, type: String

  has_many :out, :province, type: :PROVINCE, model_class: :Province
  has_many :in, :job_here, type: :CITY, model_class: :Job
  has_many :in, :education_here, type: :CITY, model_class: :Education
  has_many :in, :volunteer_work_here, type: :CITY, model_class: :VolunteerWork

end
