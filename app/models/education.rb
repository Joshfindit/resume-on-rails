class Education 
  include Neo4j::ActiveNode
  property :name, type: String
  property :more_info, type: String
  property :start_date, type: String
  property :end_date, type: String
  property :company, type: String


  has_many :out, :city, type: :CITY, model_class: :City
  has_many :out, :province, type: :PROVINCE, model_class: :Province


  
  def self.ingestEducationEntry(filename)
    # Example entry:
    # {
  #   "education": {
  #     "name": "Productivity / Business Development / Finance / IT Industry / Programming",
  #     "start_date": "2011",
  #     "end_date": "Ongoing",
  #     "company": "Various",
  #     "city": "Online Courses",
  #     "province": ""
  #   }
  # }

  puts "filename: #{filename}"
  thisParsedEntry = JSON.parse(File.read(filename))

  thisEducation = Education.merge(name: thisParsedEntry["education"]["name"])
  thisEducation.start_date = thisParsedEntry["education"]["start_date"]
  thisEducation.end_date = thisParsedEntry["education"]["end_date"]
  thisEducation.company = thisParsedEntry["education"]["company"]
  thisEducation.save

  puts thisEducation

  thisEducationCity = City.merge(name: thisParsedEntry["education"]["city"]) if thisParsedEntry["education"]["city"] != ""
  thisEducationProvince = Province.merge(name: thisParsedEntry["education"]["province"]) if thisParsedEntry["education"]["province"] != ""

  thisEducation.city = thisEducationCity
  thisEducation.province = thisEducationProvince

  end

  def self.ingestEducationFolderOfEntries(folder)
    beginning_time = Time.now #Used to calculate how long it takes to process

    rbfiles = File.join(folder, "*.json")
    Dir.glob(rbfiles) {|file|
      ingestEducationEntry(file)
      puts file
    }

    end_time = Time.now #Used to calculate how long it takes to process
    puts "Time elapsed #{(end_time - beginning_time)*1000} milliseconds" #Used to calculate how long it takes to process
  end
end
