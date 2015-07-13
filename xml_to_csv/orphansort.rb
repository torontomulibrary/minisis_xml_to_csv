require 'csv'
require 'json'
require 'set'
require 'nokogiri'

# open csv file
CSV::Converters[:blank_to_nil] = lambda do |field|
  field && field.empty? ? nil : field
end
csv = CSV.new(File.open('./dev_output/descriptions.orphans.csv'),
              headers: true,
              converters: [:all, :blank_to_nil]
             )
orphans = csv.to_a.map(&:to_hash)
puts "#{orphans.count} total orphans"

# Find the ids of missing parents and output to file
missing_parents = orphans.map { |o| o['parentId'] }.uniq
File.open('./dev_output/missing_parent_ids', 'wb') do |f|
  missing_parents.each { |r| f.puts r }
end
puts "#{missing_parents.count} missing parents!"

missing_parents.each do |parent_id|
  orphans_by_parent = orphans.select { |o| o['parentId'] == parent_id }
  puts "#{parent_id} - #{orphans_by_parent.count}"

  CSV.open("./dev_output/orphans_by_parent/#{parent_id.to_s.gsub(':', '')}.csv", 'wb') do |f|
    f << orphans_by_parent[0].keys
    orphans_by_parent.each { |r| f << r.values }
  end
end
