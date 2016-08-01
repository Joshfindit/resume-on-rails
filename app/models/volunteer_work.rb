class VolunteerWork 
  include Neo4j::ActiveNode
  property :name, type: String
  property :company, type: String
  #property :dates, type: String #Array of strings
  property :dates
  serialize :dates

  has_many :out, :city, type: :CITY, model_class: :City
  has_many :out, :province, type: :PROVINCE, model_class: :Province
  has_many :out, :skills, type: :SKILL, model_class: :Skill
  has_many :out, :tags, type: :TAG, model_class: :Tag



  def self.ingestVolunteerWorkEntry(filename)
    # Example entry:
    # {
    #   "volunteerwork": {
    #     "name": "Fundraising Organizer Assistant",
    #     "dates": ["2010","2011"],
    #     "company": "Relay For Life",
    #     "city": "Edmonton",
    #     "province": "Alberta",
    #     "tags": ["teamwork", "community", "teaching people", "integrity"]
    #   }
    #   "skills": [
    #     {
    #       "type": "IT Related",
    #       "name": "Designed a portfolio of 3 games, focusing on realistic physics and classic gameplay mechanics",
    #       "description": "",
    #       "tags": ["programming", "UX", "UI", "strategy"]
    #     },
    #     {
    #       "type": "Management and Process Related",
    #       "name": "Raised initial funding",
    #       "description": "Created investor proposals, went on-site with potential investors and presented in order to successfully secure funding",
    #       "tags": ["fundraising", "startup", "finance"]
    #     }
    #   ]
    # }


    puts "filename: #{filename}"
    thisParsedEntry = JSON.parse(File.read(filename))

    thisVolunteerWork = VolunteerWork.merge(name: thisParsedEntry["volunteerwork"]["name"])
    thisVolunteerWork.dates = thisParsedEntry["volunteerwork"]["dates"]
    thisVolunteerWork.company = thisParsedEntry["volunteerwork"]["company"]
    thisVolunteerWork.save


    if thisParsedEntry["volunteerwork"]["city"].presence
      thisVolunteerWorkCity = City.merge(name: thisParsedEntry["volunteerwork"]["city"])
    end

    if thisParsedEntry["volunteerwork"]["province"].presence
      thisVolunteerWorkProvince = Province.merge(name: thisParsedEntry["volunteerwork"]["province"])
    end

    thisVolunteerWork.city = thisVolunteerWorkCity
    thisVolunteerWork.province = thisVolunteerWorkProvince
    thisVolunteerWorkProvince.city << thisVolunteerWorkCity

    if thisParsedEntry["volunteerwork"]["tags"].presence
      thisParsedEntry["volunteerwork"]["tags"].each do |volunteertag|
        thisVolunteerWorkTag = Tag.merge(name: volunteertag)
        thisVolunteerWork.tags << thisVolunteerWorkTag
      end
    end


    if thisParsedEntry["skills"].presence
      thisParsedEntry["skills"].each do |skill|

        thisSkill = Skill.merge(name: skill["name"])
        thisSkill.description = skill["description"]

        skill["tags"].each do |skilltag|
          thisSkillTag = Tag.merge(name: skilltag)
          thisSkill.tags << thisSkillTag
        end

        if skill["type"].presence
          thisSkillCategory = SkillCategory.merge(name: skill["type"])
          thisSkill.skill_category = thisSkillCategory
        end

        thisVolunteerWork.skills << thisSkill
      end
    end
  end

  def self.ingestVolunteerWorkFolderOfEntries(folder)
    beginning_time = Time.now #Used to calculate how long it takes to process

    rbfiles = File.join(folder, "*.json")
    Dir.glob(rbfiles) {|file|
      ingestVolunteerWorkEntry(file)
      puts file
    }

    end_time = Time.now #Used to calculate how long it takes to process
    seconds_elapsed = (end_time - beginning_time)
    milliseconds_elapsed = seconds_elapsed * 1000
    puts "Time elapsed #{milliseconds_elapsed} milliseconds (#{seconds_elapsed / 60} minutes)" #Used to calculate how long it takes to process
  end


end
