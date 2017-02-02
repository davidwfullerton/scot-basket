require 'csv'
namespace :db do
  task :load_catalog_entries => :environment do
    catalog_csv = File.read('lib/assets/catalog.csv');
    catalog = (CSV.parse(catalog_csv, :headers => true)).map{|x| x.to_hash}

    catalog.each do |row|
      CatalogEntry.create!(row.to_hash)
    end
    puts "Successfully loaded entries"
  end

  task :reload_catalog_entries => :environment do
    CatalogEntry.destroy_all
    puts "Cleared old entries"
    Rake::Task['db:load_catalog_entries'].invoke
  end
end
