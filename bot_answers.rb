  module BotAnswers
  def welcome
    "Welcome to the bot. \n
    Here you can play with bot, his locations, and his facings, if you want to exit, type /end_game"
  end  

  def set_desk_message
    "Please set you desk. You need, to imput mix_x and max_x position, please take a look, that min_y and max_y will be the same"
  end 

  def desk_parameters
    "Your desk is #{@ruby_bot.desc_min_x}, #{@ruby_bot.desc_x} in cordinates X, and #{@ruby_bot.desc_min_y}, #{@ruby_bot.desc_y} in cordinates Y"
  end  

  def facing(facing)
    "Your bot is now facing to #{@facing}, You can change it facing by using one one those commands /left, or /set_facing"
  end  

  def bot_start_positions
    "You bot set random position, as #{@ruby_bot.bot_x_position} X, and #{@ruby_bot.bot_y_position} Y"
  end 

  def bot_location
    "You bot is now in #{@ruby_bot.bot_x_position}, #{@ruby_bot.bot_y_position}, #{@ruby_bot.facing}"
  end 

  def error_facing
    "Please select correct facing from facings below"
  end 

  def unknown_command
    "Unknow command, please use one of these commands /left, /right, /move, /reset, /location"
  end 

  def session
    "Please start the game /start"
  end 

  def desk_set_successfuly
    "Your desk set successfult, know you can set a facing for you bot. PLese select one facing from facings below"
  end 

  def main_bot_flow
    "Know you can play with the bot, using one of this commands /left, /right, /move, /reset, /location"
  end 
end

