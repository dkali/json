class MyJson
  attr_accessor :base_str, :cursor

  def initialize
  end

  def process_string(str)
    self.base_str = str.strip
    self.cursor = 0

    process_hash
  end

  def process_hash
    nesting_stack = []
    hash_obj = {}

    # check for start of the hash
    raise "ERROR: there is no hash found at position #{self.cursor} in string: #{base_str}" if self.base_str[self.cursor] != '{'
    self.cursor += 1

    while self.base_str[self.cursor] != '}' ||
          nesting_stack.size != 0 do
      check_for_out_of_range

      skip_delimeter
      key = get_next_object
      skip_delimeter
      val = get_next_object
      hash_obj[key] = val
    end

    hash_obj
  end

  def check_for_out_of_range
    raise "ERROR: invalid json format, } is missing" if self.cursor >= self.base_str.size
  end

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

    self.cursor += 1 # skip end quotes

    puts "found obj: '#{tmp}'"
    tmp
  end

  def skip_delimeter
    while self.base_str[self.cursor] == ' ' ||
          self.base_str[self.cursor] == ':' ||
          self.base_str[self.cursor] == ','
      self.cursor += 1
    end
  end
end