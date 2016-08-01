class Tag 
  include Neo4j::ActiveNode
  property :name, type: String

  has_many :in, :tagged_skill, type: :TAG, model_class: :Skill
  has_many :in, :tagged_profile_item, type: :TAG, model_class: :ProfileItem
  has_many :in, :tagged_volunteer_work, type: :TAG, model_class: :VolunteerWork


end