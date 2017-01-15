require 'pg'
require 'sqlite3'

module Connection
  def connection
    if BlocRecord.database_type == 'pg'
      @connection ||= PG.connect(:dbname => "address_bloc")
    else
      @connection ||= SQLite3::Database.new(BlocRecord.database_filename)
    end
  end
end
