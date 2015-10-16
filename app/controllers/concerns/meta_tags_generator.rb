module MetaTagsGenerator
  extend ActiveSupport::Concern

  def set_sns_metas
    @twitter     = {
      title: @title,
      description: @description
    }
    @og     = {
      title: @title,
      description: @description
    }
  end
end

