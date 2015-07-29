require 'pry'
require 'benchmark'
require 'csv'

require 'sax-machine'

Dir[File.dirname(__FILE__) + '/lib/**/*.rb'].each { |file| require file }

# Set class-pathname pairs
config = {
  Accession => './private_data/accessions.xml',
  Authority => './private_data/authorities.xml',
  AuthorityAlias => './private_data/authority_alias.xml',
  Description => './private_data/descriptions.xml'
}

config.each do |klass, path|
  puts "\n\nBegin Processing #{path} ..."

  total_elapsed = Benchmark.realtime do
    # Pre-process each input XML file
    tempfile = preprocess_xml(path)

    # Process the XML file to use for CSV creation
    # NB: this will return a potentially large array
    rows = process_xml(klass, tempfile)

    process_rows!(rows)

    outfile = path + '.csv'
    puts "Writing #{rows.count} rows to #{outfile} ..."

    CSV.open(outfile, 'w') do |csv|
      csv << klass.column_names.map(&:to_s)
      rows.each { |row| csv << row }
    end
  end

  puts "Processing complete in #{total_elapsed}s\n\n"
end

exit
