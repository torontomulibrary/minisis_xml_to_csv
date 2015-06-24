require 'pry'
require 'benchmark'
require 'parallel'

require 'csv'

Dir[File.dirname(__FILE__) + '/lib/**/*.rb'].each {|file| require file }

# Set class-pathname pairs
config = {
#           Accession => "./private_data/accessions.xml",
#           Authority => "./private_data/authorities.xml",
           Description => "./private_data/descriptions.xml"
         }

config.each do |klass, path|
  puts "\n\nBegin preprocessing #{path} ..."

  # Pre-process each input XML file
  tempfile = nil
  total_elapsed = Benchmark.realtime do
    tempfile = preprocess_xml(path)
  end 

  puts "Preprocessing complete in #{total_elapsed}s\n\n"  
  puts "Begin processing #{tempfile.path} ..."

  # Process the XML file to use for CSV creation
  values = nil
  total_elapsed = Benchmark.realtime do
    values = process_xml(klass, tempfile)
  end 

  puts "Processing complete in #{total_elapsed}s\n\n"  
end

exit
# ======== ALL DONE


=begin

def write_records_to_csv(records)
	CSV.open("output.csv", "ab") do |csv|
		records.each do |record|
			row = []
			@mappings.each do |key,mapping|
				concatenator = mapping[:concatenator] || '\n'
				row << parse_mapping(mapping[:map], record, concatenator)
			end
			csv << row
		end
	end
end

# TODO: Rename this method to something more useful.
def amazing_method(records, parents)
	parent_ids = parents.map do |parent|
		parent.locate("REFD")[0].text
	end

	parent_ids.each do |parent_id|
		puts "Finding records with parent id: #{parent_id}"
		children = []
		time = Benchmark.realtime do
      records.each do |record|
				el = record.locate("REFD_HIGHER")[0]
				children << record if !el.nil? && el.text == parent_id
			end
		end
		puts "Found #{children.count} records in #{time}s\n\n"
		write_records_to_csv(children)

		# See if there are child records belonging to this set of records
		records = records - children
		amazing_method(records, children)
	end

end

# write CSV header to output file
CSV.open("output.csv","wb") do |csv|
	csv << @mappings.keys
end

# Using ox
puts "--- Begin XML to CSV conversion ---"
total_elapsed = Benchmark.realtime do 
	doc = Ox.load_file("./tmp/preprocessed.xml")

	records = doc.locate("XML_RECORD")
	puts "Total number of records #{records.count}\n\n"
  
  # try to free up memory
  doc = nil
  GC.start

	puts "Finding root records"
	roots = []
	time = Benchmark.realtime do
		records.each do |record|
			roots << record if record.locate("REFD_HIGHER")[0].nil?
		end
	end
	puts "Found #{roots.count} root records in #{time}\n\n"
	write_records_to_csv(roots)

	parent_ids = roots.map do |parent|
		parent.locate("REFD")[0].text
	end

	records = records - roots
	amazing_method(records, roots)
end
=end

puts "Completed in #{total_elapsed}s\n\n"

# Forcibly remove temporary files
FileUtils.rm_rf('./tmp')