require 'pry'
require 'benchmark'
require 'parallel'

require 'csv'
require 'nokogiri'

require 'sax-machine'
require 'ox'
require 'oga'

# NB: Only one of the following are required: nokogiri, ox, oga
SAXMachine.handler = :nokogiri

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

# Set class-pathname pairs
config = {
           Accession => "./private_data/accessions.xml",
           Authority => "./private_data/authorities.xml",
#           Description => "./private_data/descriptions.xml"
         }

config.each do |klass, path|
  puts "\n\nBegin preprocessing #{path} ..."

  # Pre-process each type of input file
  tempfile = nil
  total_elapsed = Benchmark.realtime do
    tempfile = preprocess_xml(path)
  end 

  puts "Preprocessing complete in #{total_elapsed}s\n\n"
  
  
end

exit

# Define the incoming XML structure
class RecordSet
  include SAXMachine
  elements :XML_RECORD, as: :records, class: Accession # FIXME
end

xml = File.read("./tmp/preprocessed.xml")
record_set = RecordSet.parse(xml)

total_elapsed = Benchmark.realtime do
  # Parallel.each(record_set.records) do |record|
  record_set.records.each do |record|
    vals = record.class.column_names.map { |col| record.send(col) }
#puts vals.join(' ').encode('UTF-8')
  end
end

=begin

def parse_mapping(map, ox_element, concatenator='')
	col = []

  case map
  when Array
		map.each do |xpath|
			#	elements = xml_obj.xpath(xpath) # Using Nokogiri
			elements = ox_element.locate(xpath)
			elements.each do |element|
				# col << element.text.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '').gsub('"', '""')
				# We shouldnt need the .encode line anymore, because we already did it in the pre-processing
				col << element.text
			end
		end
  when Hash
		elements = ox_element.locate(map[:element])
		splitter = map[:concatenator] || '\n'
		elements.each do |element|
			col << parse_mapping(map[:map], element, splitter)
		end
  end
  
  col.join(concatenator)
end

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