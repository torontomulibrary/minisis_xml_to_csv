require 'charlock_holmes'
require 'nokogiri'
require 'tempfile'

# Set this to automatically try to detect the encoding of the input XML
# NB: it can be less than reliable, so set a sane default
DETECT_ENCODING ||= false
DEFAULT_ENCODING ||= 'ISO-8859-1'

REMOVE_ELEMENTS = %w[LOG_RECORD ACC_MOD_HIST AUTH_MOD_HIST MODIFIED_HIST]

def preprocess_xml(path)
  if DETECT_ENCODING then
    encoding = detect_encoding(path)
    puts "Detected encoding: #{encoding}."
    doc = Nokogiri::XML(File.open(path), nil, encoding)
  else
  	doc = Nokogiri::XML(File.open(path), nil, DEFAULT_ENCODING)
  end

  # Match all record elements that we want to process
  records = doc.xpath('record_set/XML_RECORD')

  puts "Preprocessing #{records.count} record nodes ..."

  # Remove unnecessary elements to reduce document size
  removed = records.map do |record|
  	record.xpath(REMOVE_ELEMENTS.join('|')).remove.count
  end

  puts "Removed #{removed.reduce(:+)} unnecessary nodes."

  # Create a tempfile to save the pre-processed XML file
  tempfile = Tempfile.new(Pathname.new(path).basename.to_s)
  output_xml = doc.to_xml(:encoding => 'UTF-8', :save_with => Nokogiri::XML::Node::SaveOptions::NO_DECLARATION)

	tempfile.write(output_xml)
  tempfile.rewind
  tempfile
end

# Detect encoding of incoming XML document
def detect_encoding(path)
  detection = CharlockHolmes::EncodingDetector.detect(File.read(path))
  detection[:encoding]  
end