require 'benchmark'
require 'nokogiri'
require './config.rb'

puts "Begin preprocessing input XML ..."
total_elapsed = Benchmark.realtime do 
	doc = Nokogiri::XML(File.open(PATH_TO_XML), nil, 'ISO-8859-1')

	doc.xpath("//XML_RECORD/LOG_RECORD").remove
	doc.xpath("//XML_RECORD/AUTH_MOD_HIST").remove
	doc.xpath("//XML_RECORD/MODIFIED_HIST").remove

	File.open('preprocessed.xml', 'wb') { |f| f.print(doc.to_xml(:encoding => 'UTF-8')) }
end
puts "Preprocessing complete in #{total_elapsed}s\n\n"