require 'csv'

def sort_it(records, parents)
  return Array.new if parents.count == 0

  ids = parents.map { |r| r[:legacyid] }

  next_level = records.select { |r| ids.include?(r[:parentid]) }

  records = records - next_level
  puts "Records remaining: #{records.count}"
  sort_it(records, next_level).unshift(*next_level)
end

CSV::Converters[:blank_to_nil] = lambda do |field|
  field && field =~ /^\s*$/ ? nil : field
end

csv = CSV.new( File.open('./private_data/descriptions.nodup.noorphan.csv'), :headers => true, :header_converters => :symbol, :converters => [:all, :blank_to_nil])

records = csv.to_a.map { |row| row.to_hash }
puts "Total records: #{records.count}"

roots = records.select { |r| r[:parentid].nil? }
puts "Found roots: #{roots.count}"

more = records - roots
puts "Records remaining: #{records.count}"


sorted = sort_it(more, roots)

sorted.unshift(*roots)
puts "Sorted array: #{sorted.count}"

remain = records - sorted
puts "Not sorted?.. : #{remain.count}"

csv_sorted = CSV.open("./private_data/descriptions.what.csv", 'wb') do |f|
  f << remain[1].keys
  remain.each { |r| f << r.values }
end

csv_sorted = CSV.open("./private_data/descriptions.sorted.csv", 'wb') do |f|
  f << sorted[1].keys
  sorted.each { |r| f << r.values }
end

