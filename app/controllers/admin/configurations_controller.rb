class Admin::ConfigurationsController < Poodle::AdminController

  before_filter :require_admin

  private

  def get_collections
    relation = QcareerConfiguration.where("")

    @filters = {}
    if params[:query]
      @query = params[:query].strip
      relation = relation.search(@query) if !@query.blank?
    end

    @per_page = params[:per_page] || "20"
    @configurations = relation.order("created_at desc").page(@current_page).per(@per_page)

    ## Initializing the @event object so that we can render the show partial
    @configuration = @configurations.first unless @configuration

    return true
  end

  def default_item_name
    "configuration"
  end

  def default_collection_name
    "configurations"
  end

  def default_class
    QcareerConfiguration
  end

  def resource_url(obj)
    admin_configuration_url(obj)
  end

  def permitted_params
    params[:qcareer_configuration].permit(:name, :value, :description)
  end

  def set_navs
    set_nav("admin/configurations")
  end

end
