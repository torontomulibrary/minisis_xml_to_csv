require 'csv'
require 'nokogiri'
require './config.rb'
require './mappings.rb'

# this is hacky! don't do this!
class String
	def concat_with(str, concatenator='')
		if self.length != 0
			replace self + concatenator + str
		else
			replace self + str
		end
	end
end

def parse_mapping(map, xml_obj, concatenator='')
	if map.kind_of? Array
		col = ''
		map.each do |xpath|
			elements = xml_obj.xpath(xpath)
			elements.each do |element|
				col.concat_with(element.text.gsub('"', '""'), concatenator)
			end
		end
		return col
	elsif map.kind_of? Hash
		x = xml_obj.xpath(map[:element])
		col = ''
		x.each do |xx|
			splitter = map[:concatenator] || '\n'
			col.concat_with(parse_mapping(map[:map], xx, splitter), concatenator)
		end
		return col
	end
end

CSV.open("output.csv", "wb") do |csv|
	csv << @mappings.keys

	File.open(XML_SOURCE) do |f|
		doc = Nokogiri::XML(f)

		records = doc.xpath(ROOT_XPATH)

		records.each do |record|
			row = []
			@mappings.each do |key, mapping|
				concatenator = mapping[:concatenator] || '\n'
				row.push('"' + parse_mapping(mapping[:map], record, concatenator) + '"')
			end
			csv << row
		end

	end

end