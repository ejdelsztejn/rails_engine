namespace :csv_import do
  desc "Destroy all data and reset primary key sequence"
  task destroy_data: :environment do
    Purchase.destroy_all
    InvoiceItem.destroy_all
    Invoice.destroy_all
    Item.destroy_all
    Merchant.destroy_all
    Customer.destroy_all

    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
    puts "Destroyed all records; reset all primary keys"
  end

  desc "Seed csv data from db/csv_files to database table"
  task seed_data: :environment do
    require "csv"

    def get_seed_data(file)
      csv = "db/csv_files/#{file}.csv"
      CSV.foreach(csv, headers: true, header_converters: :symbol).map(&:to_h)
    end

    get_seed_data("customers").each do |row|
      row[:id] = row[:id].to_i
      Customer.create(row)
    end
    puts "File: customers.csv imported"

    get_seed_data("merchants").each do |row|
      row[:id] = row[:id].to_i
      Merchant.create(row)
    end
    puts "File: merchants.csv imported"

    get_seed_data("items").each do |row|
      row[:id] = row[:id].to_i
      row[:merchant_id] = row[:merchant_id].to_i
      row[:unit_price] = (row[:unit_price].to_f / 100).round(2)
      Item.create(row)
    end
    puts "File: items.csv imported"

    get_seed_data("invoices").each do |row|
      row[:id] = row[:id].to_i
      row[:customer_id] = row[:customer_id].to_i
      row[:merchant_id] = row[:merchant_id].to_i
      Invoice.create(row)
    end
    puts "File: invoices.csv imported"

    get_seed_data("invoice_items").each do |row|
      row[:id] = row[:id].to_i
      row[:item_id] = row[:item_id].to_i
      row[:invoice_id] = row[:invoice_id].to_i
      row[:quantity] = row[:quantity].to_i
      row[:unit_price] = (row[:unit_price].to_f / 100).round(2)
      InvoiceItem.create(row)
    end
    puts "File: invoice_items.csv imported"

    get_seed_data("transactions").each do |row|
      row[:id] = row[:id].to_i
      row[:invoice_id] = row[:invoice_id].to_i
      row[:credit_card_expiration_date] = "none"
      Purchase.create(row)
    end
    puts "File: transactions.csv imported"
  end
end
