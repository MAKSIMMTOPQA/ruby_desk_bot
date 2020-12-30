require_relative "./ruby_base"

class Bot   
    # class BotNotFound < StandartError; end
    # class BotNotFacing < StandartError; end
    MIN_X = -100
    MAX_X = 100
    MIN_Y = -100
    MAX_Y = 100
    ALLOWED_FACINGS = ['NORTH', 'EAST', 'SOUTH', 'WEST']
    
    attr_accessor :session_started, :basic_setup_bot, :set_desc, :set_facing, :facing, :desc_x, :desc_y, :desc_min_x, :desc_min_y, :bot_x_position, :bot_y_position

    def initialize
        @session_started = false
        @basic_setup_bot = false
        @bot_x_position = 0
        @bot_y_position = 0
        @facing = facing
        @set_desc = false
        @set_bot = false
        @set_facing = facing ? true : false
        @desc_min_x = nil
        @desc_min_y = nil
        @desc_x = nil
        @desc_y = nil
    end 

    def setup_desk(desc_x)
        @desc_x = desc_x
        @desc_y = desc_x
        @desc_min_x = desc_x * -1
        @desc_min_y = desc_x * -1
    end
  
    def reset
        @desc_x = false
        @set_facing = false
        @facing = nil 
    end 

    def location
        @bot_x_position 
        @bot_y_position
        @facing
    end 

    def bot_position
        @bot_x_position = rand(@desc_min_x..@desc_x)
        @bot_y_position = rand(@desc_min_y..@desc_y)
    end 

    def right 
        case facing
        when 'NORTH'
            @facing = 'EAST'
        when 'EAST'
            @facing = 'SOUTH'
        when 'SOUTH'
            @facing = 'WEST' 
        when 'WEST'
            @facing = 'NORTH'
        end 
    end  

    def left 
        case @facing
        when 'NORTH'
            @facing = 'EAST'
        when 'EAST'
            @facing = 'SOUTH'
        when 'SOUTH'
            @facing = 'WEST' 
        when 'WEST'
            @facing = 'NORTH'
        end 
    end 

    def move
        case @facing
        when 'NORTH'
            @bot_y_position += 1 
        when 'EAST'
            @bot_x_position += 1
        when 'SOUTH'
            @bot_y_position -= 1
        when 'WEST'
            @bot_x_position -= 1 
        end 
    end 

    def run
        case @facing
        when 'NORTH'
            ensure_can_move('NORTH')
            @bot_y_position += 1  
        when 'EAST'
            ensure_can_move('EAST')
            @bot_x_position += 1     
        when 'WEST'    
            ensure_can_move('WEST')
            @bot_x_position -= 1 
        when 'SOUTH'
            ensure_can_move('SOUTH')
            @bot_y_position -= 1 
        end 
    end    

    # def set_desk
    #     if @set_desc = true
    #       puts "Please set new size of the desk(from 1 to 100)"
    #       @min_x = gets.chomp.to_i
    #       if @min_x < 1 || @min_x > 100
    #         puts 'Please insert correct value'
    #         return set_desk
    #       end 
    #       @max_x = gets.chomp.to_i
    #       if @max_x < 1 || @max_x > 100
    #         puts 'Please insert correct value'
    #         return set_desk
    #       end 
    #       @min_y = gets.chomp.to_i
    #       if @min_y < 1 || @min_y > 100
    #         puts 'Please insert correct value'
    #         return set_desk
    #       end 
    #       @max_y = gets.chomp.to_i
    #       if @max_y < 1 || @max_y > 100
    #         puts 'Please insert correct value'
    #         return set_desk
    #       end 
    #       puts "You new desk is #{@min_x}, #{@min_y}, #{@max_x}, #{@max_y}"
    #     else
    #       puts "Please set the size of the desk"
    #       min_x = gets.chomp
    #       max_x = gets.chomp
    #       min_y = gets.chomp 
    #       max_y = gets.chomp
    #       @set_desc = true 
    #       puts "You desk is #{min_x}, #{min_y}, #{max_x}, #{max_y}"
    #     end    
    # end 

    # def play
    #     ensure_set_desc
        
    #     case command = gets.chomp.upcase 
    #     when 'LOCATION'
    #         location
    #     when 'RIGHT'
    #         right 
    #     when 'LEFT'
    #         left 
    #     when 'SET_DESK'
    #         set_desk
    #     when 'MOVE'
    #         move
    #     when 'RESET'
    #         reset
    #     when 'EXIT'
    #         puts 'Buy'
    #         exit(0)
    #     else
    #         puts "Unknown command"    
    #     end 
    # end 

    # def play
    #     case command = gets.chomp.upcase
    #         when Command.any?{ |i| i[command].to_s }
    #         puts "Nice" 
    #     end 
    #     case command
    #     when command.eql?('LOCATION').to_s
    #         location
    #     when 'EXIT'
    #         puts 'Buy'
    #         exit(0)
    #     else
    #         puts "Unknown command" 
    #     end 
    # end 
    # def ensure_set_desc
    #   raise DescNotFound unless @set_desc
    # end    

    # def put_command 
    #     puts "Please select one of allowed commands"
    #     a = Command.list_commands
    #     puts a.join ', '
    #     ALLOWED_COMMANDS.map{ |i| puts i.split("\n") }
    # end 

    def ensure_can_move(facing)
        case facing
        when 'NORTH'
            raise StandardError 'error' if (@bot_y_position += 1) > @desc_y 
        when 'EAST'
            raise StandardError 'error' if (@bot_x_position += 1) > @desc_x  
        when 'WEST'
            raise StandardError 'error' if (@bot_x_position -= 1) < @desc_min_x   
        when 'SOUTH'
            raise StandardError 'error' if (@bot_y_position -= 1) < @desc_min_y  
        end 
    end 
    
    def can?(facing)
        case facing
        when 'NORTH'
            false if @bot_y_position = @desc_y  
        # when 'EAST'
            # raise StandardError 'error' if (@bot_x_position += 1) > @desc_x  
        # when 'WEST'
            # raise StandardError 'error' if (@bot_x_position -= 1) < @desc_min_x   
        # when 'SOUTH'
            # raise StandardError 'error' if (@bot_y_position -= 1) < @desc_min_y
        else 
          true        
        end 
    end 

    # can?(@bot.facing) ? move : error
    
    # if can?
    #   move
    # else 
    #   error 
    # end    
end 



# def post(user_id, text)
#     {
#         "ok": true,
#         "channel": user_id,
#         "ts": "1503435956.000247",
#         "message": {
#             "text": text,
#             "username": "ecto1",
#             "bot_id": "B19LU7CSY",
#             "type": "message",
#             "subtype": "bot_message",
#             "ts": "1503435956.000247"
#         }
#     }

# end



# post(user_id, text)