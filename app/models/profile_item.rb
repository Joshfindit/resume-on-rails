class ProfileItem 
  include Neo4j::ActiveNode
  property :name, type: String
  property :start_date, type: String
  property :end_date, type: String

  has_many :out, :tags, type: :TAG, model_class: :Tag


  def self.ingestProfileEntry(filename)
    # Example entry:
    # {
	#   "profile": {
	#     "name": "Enjoy focusing on completing a job properly",
	#     "start_date": "",
	#     "end_date": "",
	#     "tags": [ "organization", "strategy", "integrity", "motivation" ]
	#   }
	# }


    puts "Processing filename: #{filename}"
    thisParsedEntry = JSON.parse(File.read(filename))

    thisProfileItem = ProfileItem.merge(name: thisParsedEntry["profile"]["name"])
    thisProfileItem.start_date = thisParsedEntry["profile"]["start_date"]
    thisProfileItem.end_date = thisParsedEntry["profile"]["end_date"]
    thisProfileItem.save

	if thisParsedEntry["profile"]["tags"].presence
	  thisParsedEntry["profile"]["tags"].each do |profileItemTag|
	    thisProfileItemTag = Tag.merge(name: profileItemTag)
	    thisProfileItem.tags << thisProfileItemTag
	  end
	end
  end

  def self.ingestProfileFolderOfEntries(folder)
    beginning_time = Time.now #Used to calculate how long it takes to process

    rbfiles = File.join(folder, "*.json")
    Dir.glob(rbfiles) {|file|
      ingestProfileEntry(file)
      puts file
    }

    end_time = Time.now #Used to calculate how long it takes to process
    seconds_elapsed = (end_time - beginning_time)
    milliseconds_elapsed = seconds_elapsed * 1000
    puts "Time elapsed #{milliseconds_elapsed} milliseconds (#{seconds_elapsed / 60} minutes)" #Used to calculate how long it takes to process
  end

end
