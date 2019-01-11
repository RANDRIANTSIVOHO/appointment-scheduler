#
# WARNING:
# 
# This rake task is making the assumption that you
# know what you're doing, if you run this rake task twice
# for the same CSV file, it will populate the Database
# with duplicate records.
#
# TODO: Guard this against creating duplicates.
#
namespace :import do
  namespace :all_data do
    desc 'Import all data into the Database from the CSV file ./coaches.csv'
    task from_csv: :environment do
      num_imported = Importer.from_csv("#{Rails.root}/lib/tasks/coaches.csv")
      puts "*" * 25
      puts "Imported #{num_imported} CSV rows."
      puts "*" * 25
    end
  end
end
