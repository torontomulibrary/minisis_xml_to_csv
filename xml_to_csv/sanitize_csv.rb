require 'csv'
require 'fileutils'

def write_csv(records, filename)
  FileUtils.mkdir_p './sanitize_out'
  CSV.open("./sanitize_out/descriptions.#{filename}.csv", 'wb') do |f|
    f << records[1].keys
    records.each { |r| f << r.values }
  end
end

Dir[File.dirname(__FILE__) + '/lib/**/*.rb'].each { |file| require file }

csv_path = './private_data/descriptions.xml.csv'

# open csv file
CSV::Converters[:blank_to_nil] = lambda do |field|
  field && field.empty? ? nil : field
end
csv = CSV.new(File.open(csv_path),
              headers: true,
              converters: [:all, :blank_to_nil]
             )
records = csv.to_a.map(&:to_hash)
puts "#{records.count} total records"

# determine legacy_ids
legacy_ids = count_legacyids(records)

# Find records with non-unique legacyIds
duplicates = find_duplicate_legacy_ids(records, legacy_ids)
write_csv(duplicates, 'duplicates')
puts "#{duplicates.count} duplicate legacyids"

# Find orphaned records (referenced parentId does not exist in set of legacyId)
orphans = find_orphaned(records, legacy_ids)
write_csv(orphans, 'orphans')
puts "#{orphans.count} orphans"

# Find records with nil legacyIds
nil_records = find_nil_records(records)
write_csv(nil_records, 'nil_records')
puts "#{nil_records.count} nil records"

# Find self-referencing records
self_ref = find_self_referencing(records)
write_csv(self_ref, 'self_ref')
puts "#{self_ref.count} self referencing records"

# remove problematic records
sanitized_records = records - duplicates - orphans - nil_records - self_ref
puts "#{sanitized_records.count} records left"

# Sort the remaining records and write to file
sorted = sort_csv(sanitized_records)
write_csv(sorted, 'sorted')
puts "#{sorted.count} records sorted"

# write records that are dropped from the sort to file
dropped = sanitized_records - sorted
write_csv(dropped, 'dropped')
puts "#{dropped.count} records dropped"

# Split up the orphans by parent and write to file
FileUtils.mkdir_p './sanitize_out/orphans'
missing_parents = orphans.map { |o| o['parentId'] }.uniq
missing_parents.each do |parent_id|
  orphans_by_parent = orphans.select { |o| o['parentId'] == parent_id }
  outfile = "./sanitize_out/orphans/#{parent_id.to_s.gsub(':', '')}.csv"
  CSV.open(outfile, 'wb') do |f|
    f << orphans_by_parent[0].keys
    orphans_by_parent.each { |r| f << r.values }
  end
end
