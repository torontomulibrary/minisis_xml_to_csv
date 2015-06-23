require 'nokogiri'
require './config.rb'
# require './preprocess_xml.rb'
require PATH_TO_MAPPINGS

doc = Nokogiri::XML(File.open("preprocessed.xml"))

puts "no REFD_HIGHER :\t" + doc.xpath("//XML_RECORD[not(REFD_HIGHER)]").count.to_s
puts "TOP_LEVEL_FLAG = Y :\t" + doc.xpath("//XML_RECORD[TOP_LEVEL_FLAG[text() = 'Y']]").count.to_s

puts doc.xpath("//XML_RECORD[TOP_LEVEL_FLAG[text() = 'Y'] and REFD_LOWEREXIST]").count

# temp = doc.xpath("//XML_RECORD[not(REFD_HIGHER) and not(TOP_LEVEL_FLAG)]")
# File.open('temp.xml', 'wb') { |f| f.print(temp.to_xml(:encoding => 'UTF-8', :save_with => Nokogiri::XML::Node::SaveOptions::NO_DECLARATION)) }