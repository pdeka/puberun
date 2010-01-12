ActionController::Routing::Routes.draw do |map|
  map.resources :billboards


    map.resource  :session

    map.resources :feeds

    map.resources :notes

    map.resources :retrieve_users

    map.resources :videos

    map.resources :photos

    map.resources :musics

    map.resources :sites, :moderatorships

    map.resources :forums, :has_many => :posts do |forum|
        forum.resources :topics do |topic|
            topic.resources :posts
            topic.resource :monitorship
        end
        forum.resources :posts
    end

    map.resources :posts, :collection => {:search => :get}

    map.resources :users, :member => { :suspend   => :put,
            :settings  => :get,
            :unsuspend => :put,
            :purge     => :delete },
            :has_many => [:posts]

    map.activate '/activate/:activation_code', :controller => 'users',    :action => 'activate', :activation_code => nil
    map.signup   '/signup',                    :controller => 'users',    :action => 'new'
    map.login    '/login',                     :controller => 'sessions', :action => 'new'
    map.logout   '/logout',                    :controller => 'sessions', :action => 'destroy'
    map.settings '/settings',                  :controller => 'users',    :action => 'settings'
    map.forums    '/forums',                   :controller => 'forums',   :action => 'index'
    map.notes_phoneindex    '/notes_phoneindex',         :controller => 'notes',   :action => 'phoneindex'
    map.feeds_phoneindex    '/feeds_phoneindex',         :controller => 'feeds',   :action => 'phoneindex'

    # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
    map.root                                   :controller => "notes"


end
