require 'sax-machine'
require 'ox'

SAXMachine.handler = :ox

class RecordSet
  include SAXMachine
end

# Use the SAX parser to generate a 2-dimensonal array of mapped values
def process_xml(klass, path)
  sax_klass = RecordSet.clone
  sax_klass.elements :XML_RECORD, as: :records, class: klass

  xml = File.open(path, "r:UTF-8", &:read)
  record_set = sax_klass.parse(xml)

  puts "Processing #{record_set.records.count} record nodes ..."

  record_set.records.map do |record|
    record.class.column_names.map { |col| record.send(col) }
  end
end

# Loop over each row and process individual values in place
def process_rows!(rows)
  rows.map! do |row|
    row.map! do |value|
      if value.is_a? String
        # Replace extra whitespaces
        value.strip!
        value.squeeze!(" ")

        # Replace incorrect newlines
        value = value.gsub '<br>', "\n"
        value = value.gsub '\\n', "\n"
        value = value.squeeze("\n")
      else
        value
      end
    end
  end

  # Remove duplicate rows
  rows.uniq!
end