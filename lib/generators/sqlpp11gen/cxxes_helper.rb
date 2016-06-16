module CxxesHelper

  def coltype2ctype(coltype) 
    if coltype == 'integer'  then
      ctype = 'std::int64_t'
    elsif coltype == 'string' || coltype == 'text' then
      ctype = 'std::string'
    elsif coltype == 'datetime' or coltype.start_with?("timestamp") then
      ctype = 'sqlpp::chrono::microsecond_point'
    elsif coltype == 'decimal' then
      ctype = 'double'
    elsif coltype == 'boolean' then
      ctype = 'bool'
    else
      ctype = coltype
    end
    ctype
  end

  def sqlpptype(coltype) 
    case coltype
    when /datetime/, /\Atimestamp/
       "time_point"
    when /decimal/, /numeric/
        "floating_point"
    when /character varying/, /\Avarchar/
        "varchar"
    when /int/
        "integer"
    else
        coltype
    end      
  end

  def buildCtor(cols) 
    a = []
    cols.each do |col| 
      coltype = col.type.to_s
      if coltype == 'integer'
        a << col.name + '(0)'
      elsif coltype == 'boolean'
        a << col.name + '(false)'
      elsif coltype == 'decimal'
        a << col.name + '(0.0f)'
      end
    end
    a.join(', ')       
  end

end
