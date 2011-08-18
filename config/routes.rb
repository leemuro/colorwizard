Colorwizard::Application.routes.draw do
  match 'color' => 'home#color'
  root :to => "home#index"
end
