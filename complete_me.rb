require_relative 'node.rb'

class CompleteMe
  attr_accessor :root, :count

  def initialize
    @count = 0
  end

  def insert(word)
    @count += 1
    if root.nil?
      @root = Node.new(word)
    else
      root.advance(word)
    end
  end

  def populate(file_location)
    file_location = file_location.downcase.split("\n")
    file_location.each do |word|
      insert(word)
    end
  end

  def navigate_to_node_at_end_of_prefix_chain(partial_word)
    partial_word = partial_word.chars
    current = root
    partial_word.each do |char|
      current = current.link(char)
    end
    current
  end

  def suggest(partial_word)
    navigate_to_node_at_end_of_prefix_chain(partial_word).collect(partial_word,original_prompt=partial_word)
  end

  def select(original_prompt,selected_word)
    navigate_to_node_at_end_of_prefix_chain(selected_word).increase_selected_count(original_prompt)
  end
end