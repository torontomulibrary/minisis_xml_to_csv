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

source_xml = File.open(XML_SOURCE)
doc = Nokogiri::XML(source_xml)

File.open('output.csv', 'w') do |out|

	headings = ''
	@mappings.each do |key, mapping|
		headings.concat_with(key.to_s, ',')
	end
	out.puts headings

	records = doc.xpath(ROOT_XPATH)

	records.each do |record|
		row = ''
		@mappings.each do |key, mapping|
			concatenator = mapping[:concatenator] || '\n'
			row.concat_with('"'+ parse_mapping(mapping[:map], record, concatenator) +'"', ',')
		end
		out.puts row

	end

end

source_xml.close