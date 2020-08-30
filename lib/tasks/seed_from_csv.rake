namespace :csv_import do
  desc "Destroy all data and reset primary key sequence"
  task destroy_data: :environment do
    Transaction.destroy_all
    InvoiceItem.destroy_all
    Invoice.destroy_all
    Item.destroy_all
    Merchant.destroy_all
    Customer.destroy_all

    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
    "Destroyed all records; reset all primary keys"
  end

  desc "Seed csv data from db/csv_files to database table"
  task seed_data: :environment do
    require "csv"

    def get_seed_data(file)
      CSV.foreach("db/csv_files/#{file}")
    end

    customer_data = get_seed_data("customers.csv")
    customer_data.each do |row|
      Customer.create
    end
    puts "File: customers.csv imported"

    invoice_items_data = get_seed_data("invoice_items.csv")
    invoice_items_data.each do |row|
      InvoiceItem.create
    end
    puts "File: invoice_items.csv imported"

    invoices_data = get_seed_data("invoices.csv")
    invoices_data.each do |row|
      Invoice.create
    end
    puts "File: invoices.csv imported"

    items_data = get_seed_data("items.csv")
    items_data.each do |row|
      Item.create
    end
    puts "File: items.csv imported"

    merchants_data = get_seed_data("merchants.csv")
    merchants_data.each do |row|
      Merchant.create
    end
    puts "File: merchants.csv imported"

    transactions_data = get_seed_data("transactions.csv")
    transactions_data.each do |row|
      Transaction.create
    end
    puts "File: transactions.csv imported"
  end
end
