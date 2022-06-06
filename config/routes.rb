Rails.application.routes.draw do

  # デバイス関係------------------------------------------------------------
  devise_for :admin, controllers: {
    sessions:      "admin/sessions",
    passwords:     "admin/passwords",
  }

  devise_for :employee, controllers: {
    sessions:      "employee/sessions",
    passwords:     "employee/passwords",
    registrations: "employee/registrations"
  }

  # ゲストログイン------------------------------------------------------------
  devise_scope :employee do
    post "/employee/guest_sign_in", to: "employee/sessions#new_guest"
  end

  # 管理者ページ----------------------------------------------------------------
  namespace :admin do
    get "top" => "homes#top", as: "top"
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :employees, only: [:index, :show, :edit, :update, :destroy]
    resources :return_comments, only: [:destroy]
    resources :manuals, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  end

  # 従業員ページ----------------------------------------------------------------
  root 'public/homes#top'

  namespace :public do
    post "/homes/guest_sign_in", to: "homes#new_guest"
    resources :employees, only: [:show, :edit, :update]
    resources :comments do
      collection do
        get "search"
      end
    end
    resources :comments , only: [:index, :show, :create, :update, :destroy]
    resources :employees do
      resource :learnings, only: [:index]
    end
    resources :manuals do
      resource :learnings, only: [:create, :destroy, :index]
      collection do
        get "search"
      end
    end
    resources :manuals, only: [:index, :show, :create]
    resources :return_comments, only: [:index]

    get "employee/:id/learnings" => "learnings#employee_index", as: "learnings_employee"
    get "employee/:id/comments" => "comments#employee_comments", as: "comments_employee"
    get "employee/:id/comments/show" => "comments#employee_comments_show", as: "show_comments_employee"
    patch "comments/:id/is_desolved" => "comments#is_desolved", as: "is_desolved_comments"
    post " comments/return_comments_create" => "comments#return_comments_create", as: "create_return_comments"
    get "learnings/:id/is_learned" => "learnings#manual_is_learned", as: "is_learned_manual_learnings"
    patch "learnings/is_learned" => "learnings#is_rearned", as: "is_learned_learnings"
  end

end
