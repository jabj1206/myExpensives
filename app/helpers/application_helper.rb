module ApplicationHelper
  def bootstrap_class_for(flash_type)
    flash_types = { success: 'alert-success',
                    error: 'alert-danger',
                    alert: 'alert-warning',
                    notice: 'alert-info' }
    flash_types[flash_type.to_sym] || alert - block
  end
end
