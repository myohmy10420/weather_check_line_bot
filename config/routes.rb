Rails.application.routes.draw do
  post "webhook", to: "welcome#webhook"
end
