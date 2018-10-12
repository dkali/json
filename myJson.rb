class MyJson
  attr_accessor :base_str, :cursor

  OPEN_BRACKETS = ['{', '[']
  CLOSE_BRACKETS = ['}', ']']

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
    raise "ERROR: there is no Hash found at position #{self.cursor} in string: #{base_str}" if self.base_str[self.cursor] != '{'
    self.cursor += 1

    while self.base_str[self.cursor] != '}' do
      analyze_further = skip_delimeter
      if analyze_further
        key = get_next_object
        skip_delimeter
        val = get_next_object
        hash_obj[key] = val
      end
    end

    self.cursor += 1 # skip '}'
    hash_obj
  end

  # process Array object
  # @return [Array]
  def procecss_array
    array_obj = []

    # check for start of the array
    raise "ERROR: there is no Array found at position #{self.cursor} in string: #{base_str}" if self.base_str[self.cursor] != '['
    self.cursor += 1

    while self.base_str[self.cursor] != ']' do
      analyze_further = skip_delimeter
      if analyze_further
        val = get_next_object
        array_obj << val
      end
    end

    self.cursor += 1 # skip ']'
    array_obj
  end

  # determine next object from source string
  # @return [Variable] object of specified type that has been found next
  def get_next_object
    tmp = ""
    while self.base_str[self.cursor] == ' ' do
      self.cursor += 1 # skip whitespaces
    end

    string_detected = false
    case self.base_str[cursor]
    when '"'
      self.cursor += 1
      string_detected = true

    when '{'
      return process_hash

    when '['
      return procecss_array

    end

    # check for empty value
    if string_detected && self.base_str[self.cursor] == '"'
      self.cursor += 1
      return ""
    end

    b_continue = true
    while b_continue do
      char = self.base_str[self.cursor]
      if char == '\\'
        tmp << char
        tmp << self.base_str[self.cursor + 1]
        self.cursor += 2
      else
        tmp << char
        self.cursor += 1
      end

      b_continue = if string_detected
        self.base_str[self.cursor] != '"'
      else
        self.base_str[self.cursor] != ' ' &&
        self.base_str[self.cursor] != '}' &&
        self.base_str[self.cursor] != ']' &&
        self.base_str[self.cursor] != ','
                   end
    end

    self.cursor += 1 if string_detected # skip end quotes

    # puts "found obj: '#{tmp}'"
    tmp = eval(tmp) if not string_detected
    tmp
  end

  # @return [bool] sequence_border_detected,
  #               stop processing of hash or array if we have found the last item
  def skip_delimeter
    char = self.base_str[self.cursor]
    while self.cursor < self.base_str.size &&
        ( char == ' ' ||
          char == ':' ||
          char == ',')
      self.cursor += 1
      char = self.base_str[self.cursor]
    end

    sequence_border_detected = CLOSE_BRACKETS.include?(char)
    return (not sequence_border_detected)
  end

end