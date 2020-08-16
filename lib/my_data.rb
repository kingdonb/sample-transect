require 'csv'

class MyData
  attr_reader :rows

  def initialize
    @data = []
    @rows =
      CSV.read(Rails.root.join('lib', 'data.csv'), headers: true)
  end
end
