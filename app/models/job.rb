class Job 
  include Neo4j::ActiveNode
  property :name, type: String
  property :start_date, type: String
  property :end_date, type: String
  property :company, type: String

  has_many :out, :city, type: :CITY, model_class: :City
  has_many :out, :province, type: :PROVINCE, model_class: :Province
  has_many :out, :skills, type: :SKILL, model_class: :Skill


  def self.ingestJobEntry(filename)
    # Example entry:
    # {
    #   "job": {
    #     "name": "Freelance Web Page Implementation / Maintenance / Upkeep",
    #     "start_date": "2003",
    #     "end_date": "Ongoing",
    #     "company": "Independent/Contract Work",
    #     "city": "Local and Remote",
    #     "province": "Various Areas"
    #   },
    #   "skills": [
    #     {
    #       "type": "IT Related",
    #       "name": "Created software that manages servers in the Cloud",
    #       "description": "",
    #       "tags": ["programming", "system management"]
    #     }
    #   ]
    # }

    puts "filename: #{filename}"
    thisParsedEntry = JSON.parse(File.read(filename))

    thisJob = Job.merge(name: thisParsedEntry["job"]["name"])
    thisJob.start_date = thisParsedEntry["job"]["start_date"]
    thisJob.end_date = thisParsedEntry["job"]["end_date"]
    thisJob.company = thisParsedEntry["job"]["company"]
    thisJob.save

    puts thisJob

    if thisParsedEntry["job"]["city"].presence
      thisJobCity = City.merge(name: thisParsedEntry["job"]["city"])
    end

    if thisParsedEntry["job"]["province"].presence
      thisJobProvince = Province.merge(name: thisParsedEntry["job"]["province"])
    end

    thisJob.city = thisJobCity
    thisJob.province = thisJobProvince

    thisJobProvince.city << thisJobCity

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

        thisJob.skills << thisSkill
      end
    end
  end

  def self.ingestJobFolderOfEntries(folder)
    beginning_time = Time.now #Used to calculate how long it takes to process

    rbfiles = File.join(folder, "*.json")
    Dir.glob(rbfiles) {|file|
      ingestJobEntry(file)
      puts file
    }

    end_time = Time.now #Used to calculate how long it takes to process
    seconds_elapsed = (end_time - beginning_time)
    milliseconds_elapsed = seconds_elapsed * 1000
    puts "Time elapsed #{milliseconds_elapsed} milliseconds (#{seconds_elapsed / 60} minutes)" #Used to calculate how long it takes to process
  end

end
