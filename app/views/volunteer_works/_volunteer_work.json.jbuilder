json.extract! volunteer_work, :id, :name, :company, :dates_id, :city_id, :province_id, :skills_id, :tags_id, :created_at, :updated_at
json.url volunteer_work_url(volunteer_work, format: :json)