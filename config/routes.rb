Rails.application.routes.draw do


  devise_for :admin, controllers: {
    sessions:      "admin/sessions",
    passwords:     "admin/passwords",
  }

  devise_for :employee, controllers: {
    sessions:      "employee/sessions",
    passwords:     "employee/passwords",
    registrations: "employee/registrations"
  }

  devise_scope :employee do
    post "/employee/guest_sign_in", to: "employee/sessions#new_guest"
  end

  namespace :admin do
    get "top" => "homes#top", as: "top"
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :employees, only: [:index, :show, :edit, :update, :destroy]
    resources :comments, only: [:index, :show]
    resources :learnings, only: [:index]
    resources :manuals, only: [:index, :new, :create, :show, :edit, :update, :destroy]

    get "manual/:id/comment" => "comments#manual_comment", as: "comment_manual"
    get "employee/:id/comments" => "comments#employee_comments", as: "comments_employee"
    post "manuals/is_draft" => "manuals#is_draft", as: "is_draft_manuals"
    patch "manuals/re_draft" => "manuals#re_draft", as: "re_draft_manuals"
  end

  root 'public/homes#top'

  namespace :public do

    get '/about' => 'homes#about'
    post "/homes/guest_sign_in", to: "homes#new_guest"
    resources :employees, only: [:show, :edit, :update]
    resources :comments, only: [:show, :create, :update, :destroy]
    resources :learnings, only: [:show]
    resources :manuals, only: [:index, :show, :create]
    resources :return_comments, only: [:index]

    get "manual/:id/comment" => "comments#manual_comment", as: "comment_manual"
    get "employee/:id/comments" => "comments#employee_comments", as: "comments_employee"
    patch "comments/is_completed" => "comments#is_completed", as: "is_completed_comments"
    get "learnings/congraturation" => "learnings#congratulation", as: "congratulation_learnings"
    patch "learnings/is_learned" => "learnings#is_rearned", as: "is_learned_learnings"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
