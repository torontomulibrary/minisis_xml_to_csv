require 'charlock_holmes/string'
require 'sax-machine'
require 'ox'

SAXMachine.handler = :ox

# RecordSet
class RecordSet
  include SAXMachine
end

# Record
class Record
  include SAXMachine
end

# Use the SAX parser to generate a 2-dimensonal array of mapped values
def process_xml(klass, path)
  sax_klass = RecordSet.clone
  sax_klass.elements :XML_RECORD, as: :records, class: klass

  record_set = File.open(path, 'r:UTF-8') do |f|
    sax_klass.parse(f)
  end

  record_set.records.map do |record|
    # Normalize encoding on all values
    record.class.column_names.map do |col|
      clean_encoding(record.send(col))
    end
  end
end

def clean_encoding(string)
  return string if string.valid_encoding?
  return string unless detected = string.detect_encoding

  string.force_encoding(detected[:encoding]).encode('UTF-8', detected[:encoding], invalid: :replace, undef: :replace)
end
