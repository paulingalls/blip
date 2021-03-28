# frozen_string_literal: true

module ApplicationHelper
  def format_currency(amount)
    number_to_currency(amount, unit: '$', precision: 2, separator: '.', delimiter: '', format: '%u%n')
  end
end
