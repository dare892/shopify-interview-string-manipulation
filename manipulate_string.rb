class ManipulateString
  attr_accessor :commands

  def initialize(input, command)
    @input = input
    @cursor = 0
    @command = command
    @commands = []
  end

  def run
    parse_commands
    process_commands
    {result: @input, cursor: @cursor}
  end

  private

  def parse_commands
    counter = 0
    command_array = @command.split('')
    while counter < command_array.length
      comm = ''
      if is_i?(command_array[counter])
        temp_number = ""
        counter2 = counter
        while counter2 < command_array.length
          if is_i?(command_array[counter2])
            temp_number += command_array[counter2]
            counter += 1
            counter2 += 1
          else
            temp_number += command_array[counter2]
            if command_array[counter2] == 'r'
              comm = temp_number + command_array[counter2+1]
              counter += 1
            else
              comm = temp_number
            end
            break
          end
        end
      elsif command_array[counter] == 'r'
        comm = command_array[counter] + command_array[counter+1]
        counter += 1
      else
        comm = command_array[counter]
      end

      @commands << comm
      counter += 1
    end
    @commands
  end

  def process_commands
    @commands.each do |command|
      if command.include?('r')
        new_letter = command.split('r').last
        if command.index('r') == 0
          @input[@cursor] = new_letter
        else
          iteration = command.split('r')[0].to_i
          (1..iteration).each do |num|
            @input[@cursor] = new_letter
            @cursor += 1 if num != iteration
            fit_cursor_to_bounds
          end
        end
      else
        if command == 'h'
          @cursor -= 1
        elsif command == 'l'
          @cursor += 1
        elsif command[command.length-1] == 'h'
          iteration = command.split('h')[0].to_i
          @cursor -= iteration
        elsif command[command.length-1] == 'l'
          iteration = command.split('l')[0].to_i
          @cursor += iteration
        end
      end
      fit_cursor_to_bounds
    end
  end

  ########## helpers
  def is_i?(num)
    !!(num =~ /\A[-+]?[0-9]+\z/)
  end

  def fit_cursor_to_bounds
    if @cursor < 0
      @cursor = 0
    end
    input_length = @input.split('').length
    if @cursor > input_length-1
      @cursor = input_length-1
    end
  end
end
