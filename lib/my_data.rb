require 'csv'

class MyData
  def initialize
    @data = []
    @file =
      CSV.read(Rails.root.join('lib', 'data.csv'), headers: true)
  end
end
