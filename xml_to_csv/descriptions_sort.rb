require 'csv'

def sort_it(records, parents)
  return [] if parents.count == 0

  ids = parents.map { |r| r['legacyId'] }

  next_level = records.select { |r| ids.include?(r['parentId']) }

  records -= next_level
  puts "Records remaining: #{records.count}"
  sort_it(records, next_level).unshift(*next_level)
end

CSV::Converters[:blank_to_nil] = lambda do |field|
  field && field =~ /^\s*$/ ? nil : field
end
csv = CSV.new(File.open('./dev_output/descriptions.nodup.noorphan.csv'),
              headers: true,
              converters: [:all, :blank_to_nil]
             )

records = csv.to_a.map(&:to_hash)
puts "Total records: #{records.count}"

roots = records.select { |r| r['parentId'].nil? }
puts "Found roots: #{roots.count}"

more = records - roots
puts "Records remaining: #{records.count}"

sorted = sort_it(more, roots)

sorted.unshift(*roots)
puts "Sorted array: #{sorted.count}"

remain = records - sorted
puts "Not sorted?.. : #{remain.count}"

CSV.open('./sort_output/descriptions.dropped.csv', 'wb') do |f|
  f << remain[1].keys
  remain.each { |r| f << r.values }
end

CSV.open('./sort_output/descriptions.sorted.csv', 'wb') do |f|
  f << sorted[1].keys
  sorted.each { |r| f << r.values }
end
