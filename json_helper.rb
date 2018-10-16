# class to process incoming UTF-8 strings into ruby structures
class JsonHelper
  attr_accessor :base_str, :cursor

  OPEN_BRACKETS = ['{', '['].freeze
  CLOSE_BRACKETS = ['}', ']'].freeze

  # @param [String] str - json source text for analysis
  # @return [Hash] ruby structure constructed from source string
  def process_string(str)
    self.base_str = str.strip
    self.cursor = 0

    process_hash
  end

  # process Hash object
  # @return [Hash]
  def process_hash
    hash_obj = {}

    # check for start of the hash
    if base_str[@cursor] != '{'
      raise "ERROR: there is no Hash found at position #{@cursor} in string: #{@base_str}"
    end
    @cursor += 1

    while @base_str[@cursor] != '}'
      analyze_further = skip_delimeter
      break unless analyze_further

      key = get_next_object
      skip_delimeter
      val = get_next_object
      hash_obj[key] = val
    end

    @cursor += 1 # skip '}'
    hash_obj
  end

  # process Array object
  # @return [Array]
  def procecss_array
    array_obj = []

    # check for start of the array
    if @base_str[@cursor] != '['
      raise "ERROR: there is no Array found at position #{@cursor} in string: #{base_str}"
    end
    @cursor += 1

    while @base_str[@cursor] != ']'
      analyze_further = skip_delimeter
      if analyze_further
        val = get_next_object
        array_obj << val
      end
    end

    @cursor += 1 # skip ']'
    array_obj
  end

  # determine next object from source string
  # @return [Variable] object of specified type that has been found next
  def get_next_object
    tmp = ''
    while @base_str[@cursor] == ' '
      @cursor += 1 # skip whitespaces
    end

    string_detected = false
    case @base_str[cursor]
    when '"'
      @cursor += 1
      string_detected = true

    when '{'
      return process_hash

    when '['
      return procecss_array

    end

    # check for empty value
    if string_detected && @base_str[@cursor] == '"'
      @cursor += 1
      return ''
    end

    b_continue = true
    while b_continue
      char = @base_str[@cursor]
      tmp << char
      if char == '\\'
        tmp << @base_str[@cursor + 1]
        @cursor += 2
      else
        @cursor += 1
      end

      b_continue = if string_detected
                     @base_str[@cursor] != '"'
                   else
                     @base_str[@cursor] != ' ' &&
                     @base_str[@cursor] != '}' &&
                     @base_str[@cursor] != ']' &&
                     @base_str[@cursor] != ','
                   end
    end

    @cursor += 1 if string_detected # skip end quotes

    # puts "found obj: '#{tmp}'"
    tmp = eval(tmp) unless string_detected
    tmp
  end

  # @return [bool] sequence_border_detected,
  #               stop processing of hash or array if we have found the last item
  def skip_delimeter
    char = @base_str[@cursor]
    while @cursor < @base_str.size &&
          [' ', ':', ','].include?(char)
      @cursor += 1
      char = @base_str[@cursor]
    end

    sequence_border_detected = CLOSE_BRACKETS.include?(char)
    return (not sequence_border_detected)
  end
end
