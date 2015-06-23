require 'benchmark'
require 'nokogiri'
require './config.rb'

puts "Begin preprocessing input XML ..."
total_elapsed = Benchmark.realtime do 
	doc = Nokogiri::XML(File.open(PATH_TO_XML), nil, 'ISO-8859-1')

  records = doc.xpath('//XML_RECORD')

  records.each do |record|
  	record.xpath("LOG_RECORD | AUTH_MOD_HIST | MODIFIED_HIST").remove
  end

  puts "Processed #{records.count} record nodes."

	# We aren't using these, so we can get rid of them in the pre-process

	# ox doesnt seem to like the <?xml version="1.0" encoding="UTF-8"?> line before the data
	File.open('preprocessed.xml', 'wb') { |f| f.print(doc.to_xml(:encoding => 'UTF-8', :save_with => Nokogiri::XML::Node::SaveOptions::NO_DECLARATION)) }
end
puts "Preprocessing complete in #{total_elapsed}s\n\n"