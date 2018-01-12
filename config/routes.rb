# -*- encoding : utf-8 -*-
BsAdmin::Engine.routes.draw do
  # match '/admin' => 'Admin::sessions#new', as: :admin

  root :to => 'sessions#new'

  get 'login' => 'sessions#create', as: :login
  get 'logout' => 'sessions#destroy', as: :logout

  get 'settings-group(/:key)' => 'settings#index', as: :settings_group
  get 'edit-setting/:group_key/:type/:key' => 'settings#edit', as: :edit_setting
  put 'update-setting' => 'settings#update', as: :update_setting

  post '/assets/summernote-upload' => 'assets#summernote_upload'
  post '/assets/destroy' => 'assets#destroy', :as => :assets_destroy
  get '/assets/get(/:group)' => 'assets#get', :as => :assets_get

  get '/dashboard' => 'dashboard#index', as: :dashboard

  resources :assets, :only => [:index, :create]

  get     ':base_path/new'      => 'meta#new',     as: :meta_new
  post    ':base_path'          => 'meta#create',  as: :meta_create
  put     ':base_path/:id'      => 'meta#update',  as: :meta_update
  get     ':base_path'          => 'meta#index',   as: :meta_index
  get     ':base_path/:id/edit' => 'meta#edit',    as: :meta_edit
  get     ':base_path/:id/view' => 'meta#view',    as: :meta_view
  delete  ':base_path/:id'      => 'meta#destroy', as: :meta_destroy
  post    ':base_path/sort'     => 'meta#sort',    as: :meta_sort
  post    ':base_path/bulk_destroy'     => 'meta#bulk_destroy',    as: :meta_bulk_destroy

  get     ':base_path/:base_id/:nested_path/new'             => 'meta_nested#new',     as: :meta_nested_new
  post    ':base_path/:base_id/:nested_path'                 => 'meta_nested#create',  as: :meta_nested_create
  put     ':base_path/:base_id/:nested_path/:nested_id'      => 'meta_nested#update',  as: :meta_nested_update
  get     ':base_path/:base_id/:nested_path'                 => 'meta_nested#index',   as: :meta_nested_index
  get     ':base_path/:base_id/:nested_path/:nested_id/edit' => 'meta_nested#edit',    as: :meta_nested_edit
  get     ':base_path/:base_id/:nested_path/:nested_id/view' => 'meta_nested#view',    as: :meta_nested_view
  delete  ':base_path/:base_id/:nested_path/:nested_id'      => 'meta_nested#destroy', as: :meta_nested_destroy
  post    ':base_path/:base_id/:nested_path/sort'            => 'meta_nested#sort',    as: :meta_nested_sort
  post    ':base_path/:base_id/:nested_path/bulk_destroy'            => 'meta_nested#bulk_destroy',    as: :meta_nested_bulk_destroy

  get     ':base_path/:base_id/:nested_path/images/all'      => 'meta_image_upload#all',      as: :meta_nested_images_all
  post    ':base_path/:base_id/:nested_path/images/create'   => 'meta_image_upload#create',   as: :meta_nested_images_create
  post    ':base_path/:base_id/:nested_path/images/destroy'  => 'meta_image_upload#destroy',  as: :meta_nested_images_destroy
end
