PATH_TO_XML = 'descriptions.xml'

require 'nokogiri'
require 'json'

File.open(PATH_TO_XML) do |f|
	doc = Nokogiri::XML(f)
	records = doc.xpath('//XML_RECORD')

	node_count = {}

	records.each do |record|
		children = record.element_children

		children.each do |child|
			node_sym = child.name.gsub(/\s+/, "_").downcase.to_sym

			node_count[node_sym] = 0 if node_count[node_sym].nil? 
			node_count[node_sym] += 1
		end
	end

	File.open('output.json', 'wb') do |out|
		out << node_count.to_json
	end
end