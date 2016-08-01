json.extract! profile_item, :id, :name, :start_date, :end_date, :tags_id, :created_at, :updated_at
json.url profile_item_url(profile_item, format: :json)