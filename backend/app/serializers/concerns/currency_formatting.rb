module CurrencyFormatting
  extend ActiveSupport::Concern

  private

  def format_currency(amount)
    return { raw: 0.0, formatted: "R$ 0,00" } if amount.nil?

    {
      raw: amount.to_f,
      formatted: format_brazilian_currency(amount.to_f)
    }
  end

  def format_brazilian_currency(amount)
    # Convert to Brazilian format: R$ 1.234,56
    formatted = sprintf("%.2f", amount)
    formatted = formatted.gsub('.', ',')  # Decimal comma

    # Add thousand separators
    integer_part, decimal_part = formatted.split(',')
    integer_part = integer_part.reverse.gsub(/(\d{3})(?=\d)/, '\\1.').reverse

    "R$ #{integer_part},#{decimal_part}"
  end
end