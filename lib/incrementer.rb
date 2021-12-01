# frozen_string_literal: true

# Day-1
class Incrementer
  attr_reader :increments, :previous

  def initialize
    @increments = 0
  end

  def process(measurement)
    @increments += 1 unless previous.nil? || measurement <= previous

    @previous = measurement
  end
end
