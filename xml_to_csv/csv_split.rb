require 'csv'

CSV::Converters[:blank_to_nil] = lambda do |field|
  field && field =~ /^\s*$/ ? nil : field
end
csv = CSV.new(File.open('./sort_output/descriptions.sorted.csv'),
              headers: true,
              converters: [:all, :blank_to_nil]
             )

records = csv.to_a.map(&:to_hash)
puts "Total records: #{records.count}"

records_per_file = 2_500

while_iter = 0
while records.count > 0
  shifted = records.shift(records_per_file)
  CSV.open("./split_output/descriptions.split.#{while_iter}.csv", 'wb') do |f|
    f << shifted[0].keys
    shifted.each { |s| f << s.values }
  end
  puts records.count
  while_iter += 1
end
