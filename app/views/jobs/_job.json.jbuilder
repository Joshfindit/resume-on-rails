json.extract! job, :id, :name, :start_date, :end_date, :company, :city_id, :province_id, :skills_id, :created_at, :updated_at
json.url job_url(job, format: :json)