require 'sax-machine'
require 'nokogiri'
require 'ox'

# NB: Only one of the following are required: nokogiri, ox, oga
SAXMachine.handler = :ox

class RecordSet
  include SAXMachine
end

# Use the SAX parser to generate a 2-dimensonal array of mapped values
def process_xml(klass, path)
  sax_klass = RecordSet.clone
  sax_klass.elements :XML_RECORD, as: :records, class: klass
  
  xml = File.read(path)
  record_set = sax_klass.parse(xml)

  puts "Processing #{record_set.records.count} record nodes ..."

  # Parallel.each(record_set.records) do |record|
#  record_set.records.each do |record|
#    vals = record.class.column_names.map { |col| record.send(col) }
#puts vals.join(' ').encode('UTF-8')
#  end
end
