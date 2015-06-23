require 'benchmark'
require 'nokogiri'
require 'charlock_holmes'
require 'fileutils'
require './config.rb'

puts "Begin preprocessing input XML ..."

# Determine encoding of incoming XML document
# NB: this reads the entire file into memory, so it can be large!
detection = CharlockHolmes::EncodingDetector.detect(File.read(PATH_TO_XML))
puts "Detected encoding: #{detection[:encoding]}."

total_elapsed = Benchmark.realtime do
	doc = Nokogiri::XML(File.open(PATH_TO_XML), nil, detection[:encoding])

  # Match all record elements that we want to process
  records = doc.xpath('//XML_RECORD')

  puts "Preprocessing #{records.count} record nodes..."

  # Remove unnecessary elements to reduce document size
  records.each do |record|
  	record.xpath("LOG_RECORD | AUTH_MOD_HIST | MODIFIED_HIST").remove
  end

  FileUtils::mkdir_p 'tmp'
	# ox doesnt seem to like the <?xml version="1.0" encoding="UTF-8"?> line before the data
	File.open('./tmp/preprocessed.xml', 'wb') { |f| f.print(doc.to_xml(:encoding => 'UTF-8', :save_with => Nokogiri::XML::Node::SaveOptions::NO_DECLARATION)) }
end

# try to free up memory
detection = nil
records = nil
doc = nil
GC.start

puts "Preprocessing complete in #{total_elapsed}s\n\n"