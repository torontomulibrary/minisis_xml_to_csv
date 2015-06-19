require 'csv'
require 'nokogiri'
require './config.rb'
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

# write CSV header to output file
CSV.open("output.csv","wb") do |csv|
	csv << @mappings.keys
end

# Open XML file and begin to parse & organize it
File.open(PATH_TO_XML) do |f|
	doc = Nokogiri::XML(f)

	puts "Finding root records ...."
	root_records = doc.xpath(ROOT_ELEMENT_XPATH)
	puts "Found #{root_records.count} root records"
	write_records_to_csv(root_records)
end