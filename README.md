# ScotBasket

##Software Versions

* Ruby version 2.3.1p112

* Rails version 5.0.1

##Setup

After cloning the repository use the following steps to setup the server locally:

* Run `bundle install` to install required gems

* Run `rake db:migrate` to setup your database

* Run `rake db:load_catalog_entries` load catalog entries into the database.

* Run `bundle exec rails s` and the server will be hosted at `localhost:3000`

##Scripting

The script `load_catalog_entries` takes two CSV files, `gov_rates.csv` and `catalog.csv`, and imports the necessary data into the database under the class CatalogEntry, to be referenced later by the application.

* `gov_rates.csv` holds the data regarding VAT types and the equivalent VAT rates. This allows the rates to be easily changed if needed.
* `catalog.csv` holds the data about the products support by ScotBasket and their VAT types. If you wanted to add a new product you would create a new row in this CSV.

If you do make changes to the CSV file and want to update the database run `rake db:reload_catalog_entries`. If you run `rake db:load_catalog_entries` instead, this will result in multiple copies of the information in the database and will raise errors when the application runs. If this happens running `rake db:reload_catalog_entries` will resolve this.

##Testing

Run `bundle exec rspec spec/` to run the rspec tests. This includes the three provided test cases.
