# frozen_string_literal: true

Kaminari.configure do |config|
  # Default items per page - optimized for mobile-first Brazilian users
  config.default_per_page = 10

  # Maximum items per page to prevent performance issues
  config.max_per_page = 100

  # API parameter names
  config.page_method_name = :page
  config.param_name = :page

  # Prevent excessive pagination
  config.max_pages = 1000

  # Don't include page params on first page for cleaner URLs
  config.params_on_first_page = false
end
