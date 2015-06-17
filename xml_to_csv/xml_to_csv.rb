require 'csv'
require 'nokogiri'
require './config.rb'
require PATH_TO_MAPPINGS

def parse_mapping(map, xml_obj, concatenator='')
	col = []
	
	if map.kind_of? Array
		map.each do |xpath|
			elements = xml_obj.xpath(xpath)
			elements.each do |element|
				col.push(element.text.gsub('"', '""'))
			end
		end
		return col.join(concatenator)
	elsif map.kind_of? Hash
		elements = xml_obj.xpath(map[:element])
		splitter = map[:concatenator] || '\n'
		elements.each do |element|
			col.push(parse_mapping(map[:map], element, splitter))
		end
		return col.join(concatenator)
	end
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
				row.push(parse_mapping(mapping[:map], record, concatenator))
			end
			csv << row
		end

	end

end