require_relative 'complete_me'
require_relative 'node'

complete_me  = CompleteMe.new
dictionary = File.read("/usr/share/dict/words")
complete_me.populate(dictionary)


Shoes.app do
  background("/Users/elizabethsebian/Desktop/IMG_7761.jpg")
  stack do
    style(:margin_left =>'25%', :margin_top => '15%')
    @para = para "Lay it on me..."
    flow do
      @edit = edit_line
      @push_me = button "Find"
      @push_me.click do
        @suggestions = complete_me.suggest(@edit.text)
        @drop_box = list_box :margin_left => '25%', :items => @suggestions
      end
    end
  end
end