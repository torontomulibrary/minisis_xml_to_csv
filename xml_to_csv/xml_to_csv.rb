require 'csv'
require 'nokogiri'
require 'benchmark'
require './config.rb'
require './preprocess_xml.rb'
require PATH_TO_MAPPINGS

def parse_mapping(map, xml_obj, concatenator='')
	col = []

  case map
  when Array
		map.each do |xpath|
			elements = xml_obj.xpath(xpath)
			elements.each do |element|
				col << element.text.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '').gsub('"', '""')
			end
		end
  when Hash
		elements = xml_obj.xpath(map[:element])
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
def amazing_method(doc, record_ids)
	record_ids.each do |record_id|
		puts "Finding records with parent id: #{record_id}"
		records = nil
		elapsed = Benchmark.realtime do 
			records = doc.xpath("//XML_RECORD[REFD_HIGHER[text() = '#{record_id}']]") # takes ~1.2 seconds
		end
		puts "Found #{records.count} records in #{elapsed}s"
		write_records_to_csv(records)

		# See if there are child records belonging to this set of records
		ids = records.xpath("REFD").map(&:text)
		amazing_method(doc, ids)
	end
end

# write CSV header to output file
CSV.open("output.csv","wb") do |csv|
	csv << @mappings.keys
end

puts "Begin XML to CSV conversion"
# Open XML file and begin to parse & organize it
total_elapsed = Benchmark.realtime do 
	File.open("preprocessed.xml") do |f|

		doc = Nokogiri::XML(f)

		total_records = doc.xpath("//XML_RECORD").count
		puts "Total number of records: #{total_records}"

		puts "Finding root records ...."
		records = nil
		elapsed = Benchmark.realtime do 
			records = doc.xpath("//XML_RECORD[not(REFD_HIGHER)]") # takes ~1.2 seconds
			# records = doc.xpath("//XML_RECORD") # takes ~0.23 seconds
		end
		puts "Found #{records.count} records in #{elapsed}s"
		write_records_to_csv(records)

		# Find child records belonging to root records

		# This collects all the REFDs into a single array using 
		# the Nokogiri::XML::NodeSet#text method
		# See: http://stackoverflow.com/questions/13200256/nokogiri-returning-values-as-a-string-not-an-array
		record_ids = records.xpath("REFD").map(&:text)
		amazing_method(doc, record_ids)
	end
end
puts "Completed in #{total_elapsed}s\n\n"

# Remove generated files
File.delete("preprocessed.xml") if File.exist?("preprocessed.xml")