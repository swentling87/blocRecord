module BlocRecord
  def self.connect_to(filename, db_type)
    @database_filename = filename
    @database_type = db_type.to_s
  end

  def self.database_type
    @database_type
  end

  def self.database_filename
    @database_filename
  end

end
