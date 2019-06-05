# Dir[Rails.root.join('app', 'events', '**', '*.rb')].each { |file| require_dependency file }
# Dir[Rails.root.join('app', 'serializers', '**', '*.rb')].each { |file| require_dependency file }
# Dir[Rails.root.join('app', 'services', '**', '*.rb')].each { |file| require_dependency file }
# Dir[Rails.root.join('app', 'validations', '**', '*.rb')].each { |file| require_dependency file }

# # paths = [
# #   Rails.root.join('app', 'events'),
# #   Rails.root.join('app', 'serializers'),
# #   Rails.root.join('app', 'services'),
# #   Rails.root.join('app', 'validations'),
# # ].flatten

# # binding.pry

# # Rails.application.config.eager_load_paths << paths
# # Dir["#{Rails.root}/events/*.rb"].each { |file| require file }
# # Dir["#{Rails.root}/services/*.rb"].each { |file| require file }

# # Rails.application.config.autoload_paths += %W(#{config.root}/app)