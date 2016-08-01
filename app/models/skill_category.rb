class SkillCategory 
  include Neo4j::ActiveNode
  property :name, type: String

  has_many :in, :skills, type: :SKILL_CATEGORY, model_class: :Skill

end
