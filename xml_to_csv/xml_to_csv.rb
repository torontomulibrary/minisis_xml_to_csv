require 'pry'
require 'benchmark'

require 'csv'

Dir[File.dirname(__FILE__) + '/lib/**/*.rb'].each {|file| require file }

# Set class-pathname pairs
config = {
           Accession => "./private_data/accessions.xml",
           Authority => "./private_data/authorities.xml",
#           Description => "./private_data/descriptions.xml"
         }

config.each do |klass, path|
  puts "\n\nBegin preprocessing #{path} ..."

  # Pre-process each input XML file
  tempfile = nil
  total_elapsed = Benchmark.realtime do
    tempfile = preprocess_xml(path)
  end 

  puts "Preprocessing complete in #{total_elapsed}s\n\n"  
  puts "Begin processing #{tempfile.path} ..."

  # Process the XML file to use for CSV creation
  rows = nil
  total_elapsed = Benchmark.realtime do
    # NB: this will return a potentially large array
    rows = process_xml(klass, tempfile)
  end

  # TODO: loop over each row and process individual values

  puts "Processing complete in #{total_elapsed}s\n\n"

  outfile = path + '.csv'
  puts "Writing #{outfile} ..."

  CSV.open(outfile, 'w') do |csv|
  	csv << klass.column_names.map(&:to_s)
    rows.each {|row| csv << row}
  end

  puts "Conversion complete.\n\n"
end

exit
