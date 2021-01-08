require 'telegram/bot'
require 'byebug'
require_relative "./ruby_bot"
require_relative "./bot_answers"

Telegram::Bot::Client.run(ENV["TOKEN"]) do |bot|
  include BotAnswers
  @ruby_bot ||= Bot.new
  bot.listen do |message|
    case message
      when Telegram::Bot::Types::Message
        case message.text
        when '/start'
          @ruby_bot.session_started = true
          bot.api.sendMessage(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
          bot.api.sendMessage(chat_id: message.chat.id, text: welcome)
          bot.api.sendMessage(chat_id: message.chat.id, text: set_desk_message)
        when '/end_game'
          @ruby_bot.session_started = false
          bot.api.sendMessage(chat_id: message.chat.id, text: "Bye")
        else
          if @ruby_bot.session_started && @ruby_bot.desc_x && !@ruby_bot.set_facing

            if Bot::ALLOWED_FACINGS.include?(message.text)
              @ruby_bot.facing = message.text
              #bot.api.sendMessage(chat_id: message.chat.id, text: facing(@ruby_bot.facing))
              bot.api.sendMessage(chat_id: message.chat.id, text: "Facing = #{@ruby_bot.facing}")
              @ruby_bot.bot_position
              bot.api.sendMessage(chat_id: message.chat.id, text: bot_start_positions) 
              bot.api.sendMessage(chat_id: message.chat.id, text: bot_location)
              bot.api.sendMessage(chat_id: message.chat.id, text: main_bot_flow)
              @ruby_bot.set_facing = true    
            else 
              bot.api.sendMessage(chat_id: message.chat.id, text: error_facing)
              allowed_facing = Bot::ALLOWED_FACINGS.join(', ')
              bot.api.sendMessage(chat_id: message.chat.id, text: "#{allowed_facing}")
            end
          elsif @ruby_bot.session_started && !@ruby_bot.set_facing
            if (1..10).include?(message.text.to_i) && message.text != String.new
              @ruby_bot.setup_desk(message.text.to_i)
              bot.api.sendMessage(chat_id: message.chat.id, text: desk_parameters)
              bot.api.sendMessage(chat_id: message.chat.id, text: desk_set_successfuly)
              allowed_facing = Bot::ALLOWED_FACINGS.join(', ')
              bot.api.sendMessage(chat_id: message.chat.id, text: "#{allowed_facing}")
            else 
              bot.api.sendMessage(chat_id: message.chat.id, text: "Invalid value, try add from 1 to 10")    
            end  
          elsif @ruby_bot.session_started && @ruby_bot.desc_x && @ruby_bot.set_facing
            # if @ruby_bot.session_started && @ruby_bot.desc_x && @ruby_bot.set_facing
            #   @ruby_bot.bot_position
            #   bot.api.sendMessage(chat_id: message.chat.id, text: bot_start_positions)
            # end 
            # bot.api.sendMessage(chat_id: message.chat.id, text: main_bot_flow)
            case message.text
              when '/right'
                @ruby_bot.right
                bot.api.sendMessage(chat_id: message.chat.id, text: "Facing = #{@ruby_bot.facing}")
              when '/left'
                @ruby_bot.left
                bot.api.sendMessage(chat_id: message.chat.id, text: "Facing = #{@ruby_bot.facing}")
              when '/move'
                # @ruby_bot.run
                # bot.api.sendMessage(chat_id: message.chat.id, text: bot_location)
                if @ruby_bot.bot_x_position <= @ruby_bot.desc_min_x && @ruby_bot.facing.eql?('WEST')
                  bot.api.sendMessage(chat_id: message.chat.id, text: "You cant place like this, because your min_x is #{@ruby_bot.desc_min_x}")
                elsif @ruby_bot.bot_y_position >= @ruby_bot.desc_y && @ruby_bot.facing.eql?('SOUTH')
                  bot.api.sendMessage(chat_id: message.chat.id, text: "You cant place like this, because your Y is #{@ruby_bot.desc_y}")
                elsif @ruby_bot.bot_x_position >= @ruby_bot.desc_x && @ruby_bot.facing.eql?('EAST')
                  bot.api.sendMessage(chat_id: message.chat.id, text: "You cant place like this, because your X is #{@ruby_bot.desc_x}")
                elsif @ruby_bot.bot_y_position <= @ruby_bot.desc_min_y && @ruby_bot.facing.eql?('NORTH')
                  bot.api.sendMessage(chat_id: message.chat.id, text: "You cant place like this, because your Y is #{@ruby_bot.desc_min_y}")
                else 
                  @ruby_bot.move
                  bot.api.sendMessage(chat_id: message.chat.id, text: bot_location)
                end 
              when '/location'
                @ruby_bot.location
                bot.api.sendMessage(chat_id: message.chat.id, text: bot_location)
              when '/reset'
                @ruby_bot.reset
              else                 
                bot.api.sendMessage(chat_id: message.chat.id, text: unknown_command)   
            end 
          elsif !@ruby_bot.session_started
            bot.api.sendMessage(chat_id: message.chat.id, text: session)  
        end 
      end 
    end
  end

  # rescue StandardError
  #   Telegram::Bot::Client.run(token) do |bot|
  #     bot.listen do |message|
  #       bot.api.sendMessage(chat_id: message.chat.id, text: "can't move, please change your facing")
  #     end
  #   end  
end


# def send_message(token, user_id, text)
#   Telegram::Bot::Client.run(token) do |bot|
#     bot.listen do |message|
#       bot.api.sendMessage(chat_id: message.chat.id, text: "can't move, please change your facing")
#     end
#   end  
# end


# send_message('123213213132', 'ID123213123', 'welcome')