require './lib/my_data'

class TableLoader
  attr_reader :m

  def initialize
    @m = MyData.new
  end

  def call
    m.rows.each do |d|
      SampleData.new(id:            d['Replicate'],
                     pond_zone:     d['Pond zone'],
                     sample_count:  d['Invertebrate count'])
        .save!
    end
  end
end
