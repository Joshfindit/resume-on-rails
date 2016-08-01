namespace :resume do
  desc "Placeholder for the resume-specific tasks"
  task :import_all => :environment do
    Education.ingestEducationFolderOfEntries("data/Education")
    Job.ingestJobFolderOfEntries("data/Experience (post 2001)")
    ProfileItem.ingestProfileFolderOfEntries("data/Profile")
    VolunteerWork.ingestVolunteerWorkFolderOfEntries("data/Volunteer Work")
  end
  task :remove_duplicate_relationships => :environment do
    Skill.all.each do |skill|
      skill.tags.each do |tag|
        skill.tags.first_rel_to(tag).destroy if (skill.tags.match_to(tag).count > 1)   
      end
    end
    Province.all.each do |province|
      province.city.each do |city|
        province.city.first_rel_to(city).destroy if (province.city.match_to(city).count > 1)   
      end
    end
    
  end
end
