require 'pg'
require 'sqlite3'
require 'bloc_record/utility'

module Schema
  def table
    BlocRecord::Utility.underscore(name)
  end

  def columns
    schema.keys
  end

  def attributes
    columns - ["id"]
  end

  def schema
    unless @schema
      @schema = {}
      if BlocRecord.database_type == 'pg'
        cols = connection.exec <<-SQL
          SELECT *
          FROM #{table}
          WHERE Id=0;
        SQL

         cols.fields.each do |col|
          @schema[col["name"]] = col["type"]
        end
      else
        connection.table_info(table) do |col|
          @schema[col["name"]] = col["type"]
        end
      end
    end
    @schema
  end

  def count
    connection.execute(<<-SQL)[0][0]
      SELECT COUNT(*) FROM #{table}
      SQL
  end
end
