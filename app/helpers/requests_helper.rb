module RequestsHelper
  def request_type_select
    Request.request_types.keys.map{|i| i}
  end
end
