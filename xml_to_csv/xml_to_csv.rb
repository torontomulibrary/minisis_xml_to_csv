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
    # Process the XML file to use for CSV creation
    # NB: this will return a potentially large array
    rows = process_xml(klass, path)

    process_rows!(rows)

    outfile = path + '.csv'
    puts "Writing #{rows.count} rows to #{outfile} ..."

    CSV.open(outfile, 'w') do |csv|
      csv << klass.column_names.map(&:to_s)
      rows.each { |row| csv << row }
    end
  end

  puts "Processing complete in #{total_elapsed}s\n\n"

  # save the list of accession numbers to file
  if klass == Accession
    data = []
    CSV.foreach('./private_data/accessions.xml.csv') { |row| data << row[0] }
    File.open('./private_data/accessionNumbers', 'w+') { |f| f.puts(data) }
  end
end

exit
