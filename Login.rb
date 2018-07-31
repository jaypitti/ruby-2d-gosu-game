require 'rubygems'
require 'net/http'
require 'uri'
require 'gosu'
require './Game.rb'

class TextField < Gosu::TextInput
  FONT = Gosu::Font.new(20)
  WIDTH = 350
  LENGTH_LIMIT = 20
  PADDING = 5

  INACTIVE_COLOR  = 0xcc_666666
  ACTIVE_COLOR    = 0xcc_ff6666
  SELECTION_COLOR = 0xcc_0000ff
  CARET_COLOR     = 0xff_ffffff

  attr_reader :x, :y

  def initialize(window, x, y)
    # It's important to call the inherited constructor.
    super()

    @window, @x, @y = window, x, y

    # Start with a self-explanatory text in each field.
    self.text = "Click to edit"
  end

  # In this example, we use the filter method to prevent the user from entering a text that exceeds
  # the length limit. However, you can also use this to blacklist certain characters, etc.
  def filter new_text
    allowed_length = [LENGTH_LIMIT - text.length, 0].max
    new_text[0, allowed_length]
  end

  def draw(z)
    # Change the background colour if this is the currently selected text field.
    if @window.text_input == self
      color = ACTIVE_COLOR
    else
      color = INACTIVE_COLOR
    end
    Gosu.draw_rect x - PADDING, y - PADDING, WIDTH + 2 * PADDING, height + 2 * PADDING, color, z

    # Calculate the position of the caret and the selection start.
    pos_x = x + FONT.text_width(self.text[0...self.caret_pos])
    sel_x = x + FONT.text_width(self.text[0...self.selection_start])
    sel_w = pos_x - sel_x

    # Draw the selection background, if any. (If not, sel_x and pos_x will be
    # the same value, making this a no-op call.)
    Gosu.draw_rect sel_x, y, sel_w, height, SELECTION_COLOR, z

    # Draw the caret if this is the currently selected field.
    if @window.text_input == self
      Gosu.draw_line pos_x, y, CARET_COLOR, pos_x, y + height, CARET_COLOR, z
    end

    # Finally, draw the text itself!
    FONT.draw self.text, x, y, z
  end

  def height
    FONT.height
  end

  # Hit-test for selecting a text field with the mouse.
  def under_mouse?
    @window.mouse_x > x - PADDING and @window.mouse_x < x + WIDTH + PADDING and
      @window.mouse_y > y - PADDING and @window.mouse_y < y + height + PADDING
  end  
  # Tries to move the caret to the position specifies by mouse_x
  def move_caret_to_mouse
    # Test character by character
    1.upto(self.text.length) do |i|
      if @window.mouse_x < x + FONT.text_width(text[0...i])
        self.caret_pos = self.selection_start = i - 1;
        return
      end
    end
    # Default case: user must have clicked the right edge
    self.caret_pos = self.selection_start = self.text.length
  end
end

class Login < (Example rescue Gosu::Window)
  def initialize
    super 640, 480
    self.caption = "LOGIN"


    text = "RUBY 2D"

    # Remove all leading spaces so the text is left-aligned
    text.gsub! /^ +/, ''

    @text = Gosu::Image.from_text text, 20, :width => 540

    # Set up an array of three text fields.
    @text_fields = Array.new(2) { |index| TextField.new(self, 50, 300 + index * 50) }
    @text_fields[0].text = "User Name"
    @text_fields[1].text = "Password"
  end

  def needs_cursor?
    true
  end

  def draw
    color = 0xcc_C0C0C0

    if  self.mouse_x > 450 and self.mouse_x < 450 + 125 and
        self.mouse_y > 310 and self.mouse_y < 310 + 50
      color = 0xcc_00FFFF
    else
      color = 0xcc_C0C0C0
    end
    @text.draw 50, 50, 0
    @text_fields.each { |tf| tf.draw(0) }
    @test = Gosu::Image.from_text "LOGIN", 30, :width => 125
    @login_button = Gosu.draw_rect 450, 300, 125, 50, color, 0
    @test.draw 470, 310, 1

  end

  def button_down(id)
    if id == Gosu::KB_TAB
      # Tab key will not be 'eaten' by text fields; use for switching through
      # text fields.
      index = @text_fields.index(self.text_input) || -1
      self.text_input = @text_fields[(index + 1) % @text_fields.size]
    elsif id == Gosu::KB_ESCAPE
      # Escape key will not be 'eaten' by text fields; use for deselecting.
      if self.text_input
        self.text_input = nil
      else
        close
      end
    elsif id == Gosu::MS_LEFT

      button = ""
      # Mouse click: Select text field based on mouse position.
      self.text_input = @text_fields.find { |tf| tf.under_mouse? }
      # Also move caret to clicked position

      if  self.mouse_x > 450 and self.mouse_x < 450 + 125 and
          self.mouse_y > 310 and self.mouse_y < 310 + 50 
        @game = Game.new @text_fields[0].text, "", "1234"
        @game.show
        close
      end
      self.text_input.move_caret_to_mouse unless self.text_input.nil?
    elsif id == Gosu::KB_RETURN

      @game = Game.new @text_fields[0].text, "", "1234"
      @game.show

      #      uri = URI('https://example.com/some_path?query=string')
      #     response = Net::HTTP.start(uri.host, uri.port) do |http|
      #    request = Net::HTTP::Get.new uri.request_uri
      #   http.request request
      close
      #      end
    else
      super
    end
  end
end

Login.new.show if __FILE__ == $0
