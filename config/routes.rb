Rails.application.routes.draw do


  devise_for :admin, controllers: {
    sessions:      "admin/sessions",
    passwords:     "admin/passwords",
    registrations: "admin/registrations"
  }

  devise_for :employees, controllers: {
    sessions:      "employees/sessions",
    passwords:     "employees/passwords",
    registrations: "employees/registrations"
  }

  namespace :admin do
    get "top" => "homes/top", as: "top"
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :employees, only: [:index, :show, :edit, :update]
    resources :comments, only: [:index, :show]
    resources :learnings, only: [:index]
    resources :manuals, only: [:index, :new, :create, :show, :edit, :update, :destroy]

    post "manuals/is_draft" => "manuals#is_draft", as: "is_draft_manuals"
    patch "manuals/re_draft" => "manuals#re_draft", as: "re_draft_manuals"
  end

  namespace :public do
    root 'homes#top'
    get '/about' => 'homes#about'
    resources :employees, only: [:show, :edit, :update]
    resources :comments, only: [:show, :create, :update, :destroy]
    resources :learnings, only: [:show]
    resources :manuals, only: [:index, :show]

    patch "comments/is_completed" => "comments#is_completed", as: "is_completed_comments"
    get "learnings/congraturation" => "learnings#congratulation", as: "congratulation_learnings"
    patch "learnings/is_learned" => "learnings#is_rearned", as: "is_learned_learnings"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
