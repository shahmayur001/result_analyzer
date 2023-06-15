# frozen_string_literal: true

class ResultsData < ApplicationRecord
  validates_presence_of :subject, :timestamp, :marks
  # Considering there could be chances where user marks are 0
  # validates :marks, numericality: { greater_than: 0.0 }
end
