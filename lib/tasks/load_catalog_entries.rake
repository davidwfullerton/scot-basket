require 'csv'
namespace :db do
  task :load_catalog_entries => :environment do
    catalog_csv = File.read('lib/assets/catalog.csv');
    gov_rates_csv = File.read('lib/assets/gov_rates.csv');

    catalog = (CSV.parse(catalog_csv, :headers => true)).map{|x| x.to_hash}
    gov_rates = (CSV.parse(gov_rates_csv, :headers => true))

    catalog.each do |row|
      i = gov_rates.by_col[0].index(row['vat_type'])
      rates = {"vat_rate" => gov_rates[i][1]}
      entry = row.except('vat_type').merge rates

      puts "Importing catalog entry for #{entry['name']}."
      CatalogEntry.create(entry)
    end

    puts "Successfully loaded entries"
  end

  task :reload_catalog_entries => :environment do
    CatalogEntry.destroy_all
    puts "Clearing old entries"
    Rake::Task['db:load_catalog_entries'].invoke
  end
end
