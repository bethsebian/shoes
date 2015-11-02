class Node
  attr_reader :prompts_hash, :links_hash

  def initialize(word_rest="")
    word_rest.class == String ? (word_rest = word_rest.chars) : word_rest
    @word_indicator = false
    @links_hash = Hash.new
    @prompts_hash = Hash.new
    advance(word_rest)
  end

  def advance(word)
    word.class == String ? (input_array = word.chars) : (input_array = word)
    if input_array.empty?
      @word_indicator = true
    elsif @links_hash[input_array[0]]
      existing_link = @links_hash[input_array[0]]
      input_array.shift
        if input_array.empty?
          existing_link.advance([])
        else existing_link.advance(input_array)
        end
      else create_child(input_array)
    end
  end

  def create_child(word)
    word.class == String ? (input_array = word.chars) : (input_array = word)
    key = input_array[0]
    input_array.shift
    add_key_and_new_node_link_to_hash(key, value = Node.new(input_array))
  end

  def word?
    @word_indicator
  end

  def collect(prefix,prompt,word_list=Hash.new)
    if @word_indicator == true
      if prompts_hash[prompt].nil?
        word_list[prefix] = 0
      else
        word_list[prefix] = @prompts_hash[prompt]
      end
    end
    if !links_hash.empty?
      @links_hash.each do |key, value|
        value.collect(prefix+key,prompt,word_list)
      end
    end
    sort_hash_of_potential_words(word_list)
  end


  def sort_hash_of_potential_words(word_list)
    word_list = word_list.sort do |a,b|
      comp = (-a[1] <=> -b[1])
      comp.zero? ? (a[0] <=> b[0]) : comp
    end
    Hash[word_list].keys
  end


  def add_key_and_new_node_link_to_hash(key,value)
    @links_hash[key] = value
  end

  def link(key)
    @links_hash[key]
  end

  def returns(key)
    # @links_hash[key] ? @links_hash[key] : "bam"
    @links_hash[key] || "bam"
  end

  def increase_selected_count(key)
    if @prompts_hash[key].nil?
      @prompts_hash[key] = 1
    else
      selected_times = @prompts_hash[key]
      @prompts_hash[key] += 1
    end
  end
end