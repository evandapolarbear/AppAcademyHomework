require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns

    results =  DBConnection.execute2(<<-SQL)
      SELECT *
      FROM "#{table_name}"
    SQL

    @columns ||= results[0].map{|x| x.to_sym}
  end

  def self.finalize!

    self.columns.each do |sym|
      define_method("#{sym}") do
        self.attributes[sym]
      end

      define_method("#{sym}=") do |val|
        self.attributes[sym] = val
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.name.to_s.downcase + 's'
  end


  #tried "#{self.class}s" id: id

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT *
      FROM "#{table_name}"
    SQL
    self.parse_all(results)
  end

  def self.parse_all(results)
    objs = []
    results.each do |r|
      objs << self.new(r)
    end
    objs
  end

  def self.find(id)
    obj = DBConnection.execute(<<-SQL, id)
      SELECT *
      FROM "#{table_name}"
      WHERE id = ?
    SQL

    self.parse_all(obj)[0]
  end

  def initialize(params = {})
    params.each do |key, val|
      unless self.class.columns.include?(key.to_sym)
        raise "unknown attribute '#{key}'"
      end

      self.send("#{key}=", val)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    results = []
    @attributes.each do |key, val|
      results << val
    end
    results
  end

  def insert
    col_name = self.class.columns.drop(1).join(', ')

    num_q = []
    self.attributes.each do |attr, _|
      num_q << "?"
    end

    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO #{self.class.table_name} (#{col_name})
      VALUES (#{num_q.join(',')})
      SQL

      self.id = DBConnection.last_insert_row_id
  end

  def update
    set_line = self.class.columns.map{|c| c.to_s + "= ?" }
    set_line = set_line.drop(1).join(',')
    att = attribute_values.drop(1)

    DBConnection.execute(<<-SQL, *att)
      UPDATE #{self.class.table_name}
      SET #{set_line}
      WHERE id = #{self.id}
    SQL

  end

  def save
    if self.id.nil?
      self.insert
    else
      self.update
    end
  end
end
