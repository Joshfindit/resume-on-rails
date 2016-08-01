class Skill 
  include Neo4j::ActiveNode
  property :name, type: String
  property :description, type: String

  has_many :out, :tags, type: :TAG, model_class: :Tag
  has_many :out, :skill_category, type: :SKILL_CATEGORY, model_class: :SkillCategory
  has_many :in, :jobs, type: :SKILL, model_class: :Job
  has_many :in, :volunteer_work, type: :SKILL, model_class: :VolunteerWork
 
end