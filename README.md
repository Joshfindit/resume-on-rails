City
	rails generate scaffold City name:string province:references experience_here:references education_here:references
		province:out:has_many Province
		experience_here:in:has_many Job
		education_here:in:has_many Education

Province
	rails generate scaffold Province name:string city:references experience_here:references education_here:references
		city:in:has_many City
		experience_here:in:has_many Job
		education_here:in:has_many Education

Job
	rails generate scaffold Job name:string start_date:string end_date:string company:string city:references province:references skills:references
		city:out:has_many City
		province:out:has_many Province
		skills:out:has_many Skill

Skill 
	rails generate scaffold Skill name:string description:text tags:references skill_category:references jobs:references
		tags:out:has_many Tag
		skill_category:out:has_many Skill_Category
		jobs:in:has_many Job

Tag
	rails generate scaffold Tag name:string tagged_skill:references tagged_profile_item:references
		tagged_skill:in:references has_many Skill
		tagged_profile_item:in:has_many Profile_Item

Skill_Category
	rails generate scaffold Skill_Category name:string skills:references
		skills:in:has_many Skill

Profile_Item
	rails generate scaffold Profile_Item name:string start_date:string end_date:string tags:references
	tags:out:has_many Tag

Education
	rails generate scaffold Education name:string start_date:string end_date:string company:string city:references province:references
		city:out:has_many City
		province:out:has_many Province