class Province 
  include Neo4j::ActiveNode
  property :name, type: String

  has_many :in, :city, type: :PROVINCE, model_class: :City
  has_many :in, :job_here, type: :PROVINCE, model_class: :Job
  has_many :in, :education_here, type: :PROVINCE, model_class: :Education
  has_many :in, :volunteerwork_here, type: :PROVINCE, model_class: :VolunteerWork


end
