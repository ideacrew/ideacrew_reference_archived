require 'dry-validation'

class Validations::ApplicationSchema < Dry::Validation::Schema

  configure do |config|
    # config.messages_file = '/my/app/config/locales/en.yml'
    # config.messages = :i18n
  end

  def email?(value)
    true
  end

  # define common rules, if any
  define! do

    def strip_whitespace(str)
      str ? str.strip.chomp : str    
    end

    def starts_with_uppercase?(value)
      value =~ /^[A-Z]*/ # check that the first character in our string is uppercase
    end
  end

  # now you can build other schemas on top of the base one:
  Dry::Validation.Schema(AppSchema) do
    # define your rules
  end
end