class MyJson
  attr_accessor :base_str, :cursor

  OPEN_BRACKETS = ['{', '[']
  CLOSE_BRACKETS = ['}', ']']

  def initialize
  end

  # @param [String] str - json source text for analysis
  # @return [Hash] ruby structure constructed from source string
  def process_string(str)
    self.base_str = str.strip
    self.cursor = 0

    process_hash
  end

  # process Hash object
  def process_hash
    hash_obj = {}

    # check for start of the hash
    raise "ERROR: there is no hash found at position #{self.cursor} in string: #{base_str}" if self.base_str[self.cursor] != '{'
    self.cursor += 1

    while self.base_str[self.cursor] != '}' do
      # check_for_out_of_range

      analyze_further = skip_delimeter
      if analyze_further
        key = get_next_object
        skip_delimeter
        val = get_next_object
        hash_obj[key] = val
      end
    end

    hash_obj
  end

  # determine next object from source string
  # @return [Variable] object of specified type that has been found next
  def get_next_object
    tmp = ""
    while self.base_str[self.cursor] == ' ' do
      self.cursor += 1 # skip whitespaces
    end

    string_detected = false
    if self.base_str[cursor] == '"'
      self.cursor += 1
      string_detected = true
    end

    b_continue = true
    while b_continue do
      char = self.base_str[self.cursor]
      tmp << char
      self.cursor += 1

      # check for quotes inside the text value
      if char == '\\' && self.base_str[self.cursor] == '"'
        tmp << self.base_str[self.cursor]
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