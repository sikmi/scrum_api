module BaseModel
  extend ActiveSupport::Concern
  included do

    # common module
    include Crud
    # include I18nMapping
    # include View
  end

end
