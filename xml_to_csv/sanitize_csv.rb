require 'csv'
require 'fileutils'

Dir[File.dirname(__FILE__) + '/lib/**/*.rb'].each { |file| require file }

# open csv file
csv_path = ARGV[0]
csv = CSV.new(File.open(csv_path),
              headers: true,
              converters: [:all, :blank_to_nil]
             )
records = csv.to_a.map(&:to_hash)
puts "#{records.count} total records"

# determine legacy_ids
legacy_ids = count_legacyids(records)

# Find records with non-unique legacyIds
conflicting = find_duplicate_legacy_ids(records, legacy_ids)
write_csv(conflicting, 'conflicting') if conflicting.count > 0
puts "#{conflicting.count} conflicting legacyids"

# Find orphaned records (referenced parentId does not exist in set of legacyId)
orphans = find_orphaned(records, legacy_ids)
write_csv(orphans, 'orphans') if orphans.count > 0
puts "#{orphans.count} orphans"

# Find records with nil legacyIds
nil_records = find_nil_records(records)
write_csv(nil_records, 'nil_records') if nil_records.count > 0
puts "#{nil_records.count} nil records"

# Find self-referencing records
self_ref = find_self_referencing(records)
write_csv(self_ref, 'self_ref') if self_ref.count > 0
puts "#{self_ref.count} self referencing records"

# remove problematic records before passing it to sort method
sanitized_records = records - conflicting - orphans - nil_records - self_ref
puts "#{sanitized_records.count} records left"

# Sort the remaining records and write to file
sorted = sort_csv(sanitized_records)
write_csv(sorted, 'sorted') if sorted.count > 0
puts "#{sorted.count} records sorted"

# write records that are dropped from the sort to file
dropped = sanitized_records - sorted
write_csv(dropped, 'dropped') if dropped.count > 0
puts "#{dropped.count} records dropped"

# Split up the orphans by parent and write to file
FileUtils.mkdir_p './sanitize_out/orphans'
missing_parents = orphans.map { |o| o['parentId'] }.uniq
File.open('./sanitize_out/orphans/!missing_parent_ids', 'wb') do |f|
  missing_parents.each do |id|
    f.puts id
  end
end
missing_parents.each do |parent_id|
  orphans_by_parent = orphans.select { |o| o['parentId'] == parent_id }
  outfile = "./sanitize_out/orphans/#{parent_id.to_s.gsub(':', '')}.csv"
  CSV.open(outfile, 'wb') do |f|
    f << orphans_by_parent[0].keys
    orphans_by_parent.each { |r| f << r.values }
  end
end
