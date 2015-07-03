require 'csv'

def sort_it(records, parents)
  return Array.new if parents.count == 0

  ids = parents.map { |r| r[:legacyid] }

  next_level = []
  records.each do |r|
    next_level << r if ids.include?(r[:parentid])
  end

  records = records - next_level

  sort_it(records, next_level).unshift(*next_level)
end

CSV::Converters[:blank_to_nil] = lambda do |field|
  field && field.empty? ? nil : field
end

csv = CSV.new( File.open('./private_data/descriptions.xml.csv'), :headers => true, :header_converters => :symbol, :converters => [:all, :blank_to_nil])

records = csv.to_a.map { |row| row.to_hash }
roots = []

records.each do |r|
  roots << r if r[:parentid].nil?
end

records = records - roots
sorted = sort_it(records, roots)

sorted.unshift(*roots)

csv_sorted = CSV.open("./private_data/descriptions.sorted.csv", 'wb') do |f|
  f << sorted[1].keys
  sorted.each { |r| f << r.values }
end

