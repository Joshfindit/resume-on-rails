Rails.application.routes.draw do
  resources :resumes, path: 'resume'
  root 'resumes#index'
  resources :volunteer_works, path: "volunteer_work"
  resources :educations, path: "education"
  resources :tags
  resources :profile_items
  resources :provinces
  resources :cities
  resources :jobs
  resources :skill_categories
  resources :skills
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
