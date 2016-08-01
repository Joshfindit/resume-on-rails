json.extract! education, :id, :name, :more_info, :start_date, :end_date, :company, :city_id, :province_id, :created_at, :updated_at
json.url education_url(education, format: :json)