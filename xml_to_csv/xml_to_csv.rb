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
				col << element.text.gsub('"', '""')
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

CSV.open("output.csv", "wb") do |csv|
	csv << @mappings.keys

	File.open(PATH_TO_XML) do |f|
		doc = Nokogiri::XML(f)

		records = doc.xpath(ROOT_ELEMENT_XPATH)

		records.each do |record|
			row = []
			@mappings.each do |key, mapping|
				concatenator = mapping[:concatenator] || '\n'
				row << parse_mapping(mapping[:map], record, concatenator)
			end
			csv << row
		end

	end

end