# frozen_string_literal: true

module DataReader
  def self.get_lines(day)
    File.readlines("input/day-#{day}.txt", chomp: true)
  end

end