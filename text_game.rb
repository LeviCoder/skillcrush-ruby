
$current_room = "cellar"
$quit = false;

def ask
  print "> "
  return gets.downcase.delete_suffix("\n");
end

class Item
  def initialize(name, desc, grammar)
    @name = name
    @desc = desc
    @grammar = grammar
    @moved = false;
  end
  def return_desc
    if @moved == false
      return @desc
    else
      return "lying on the floor #{@grammar} #{@name}."
    end
  end
  def return_name
    return @name
  end
  def move
    moved = true
  end
end

$items = {
  "grippy boots" => Item.new("grippy boots", "there's a pair of grippy boots in the corner.", "are a pair of"),
}

$rooms = {
  "cellar" => {
    :desc => "the main room! has a passage to the south and a slippery slide to the east.",
    "n" => [false, "a rough stone wall blocks your way"],
    "e" => [false, "can't climb that slide ya'll"],
    "s" => [true, "passage"],
    "w" => [false, "a rough stone wall blocks your way"],
    :items => [],
  },
  "passage" => {
    :desc => "a dark passage leading north and south.",
    "n" => [true, "cellar"],
    "e" => [false, "a rough stone wall blocks your way"],
    "s" => [true, "round room"],
    "w" => [false, "a rough stone wall blocks your way"],
    :items => [],
  },
  "round room" => {
    :desc => "a large circular room with an arched ceiling. to the east are dim stair steps, and a door opens to the north.",
    "n" => [true, "passage"],
    "e" => [true, "upstairs"],
    "s" => [false, "a stucco wall blocks your way"],
    "w" => [false, "a stucco stone wall blocks your way"],
    :items => ["grippy boots"],
  },
  "upstairs" => {
    :desc => "a low upper room. stairs descend to the west and there's a laundry chute to the north.",
    "n" => [true, "cellar"],
    "e" => [false, "a rough stone wall blocks your way"],
    "s" => [false, "a rough stone wall blocks your way"],
    "w" => [true, "round room"],
    :items => [],
  },
}
def print_room(r)
  puts "\n\n-~* #{$current_room.upcase} *~-\n"
  puts $rooms[r][:desc]
  for i in $rooms[r][:items]
    puts $items[i].return_desc
  end
end


def handle_player_motion(i)
  if (i == "n" || i == "s" || i == "e" || i == "w" || i == "north" || i == "south" || i == "east" || i == "west")
    i = i[0]
    if $rooms[$current_room][i][0] == true
      $current_room = $rooms[$current_room][i][1]
      print_room($current_room)
      handle_player
    else
      puts $rooms[$current_room][i][1]
      handle_player
    end
  end
end
def game_functions(i)
  if i == "help"
    puts "\n\n***** HELP *****\n\n"
    puts "+----------------------------------+"
    puts "| n OR north ............ go north |"
    puts "| s OR south ............ go south |"
    puts "| e OR east .............. go east |"
    puts "| w OR west .............. go west |"
    puts "+----------------------------------+"
    puts "| quit ............. exit the game |"
    puts "| help ....................... duh |"
    puts "| look .. print room's description |"
    puts "+----------------------------------+\n\n"
    handle_player
  elsif i == "look" || i == "look around"
    print_room($current_room)
    handle_player
  end
end
def handle_player
  if $quit == false
    input = ask
    handle_player_motion(input)
    game_functions(input)


    if input == "quit"
      puts "\nAre you sure you want to quit? (y/n)"
      if ask == "y"
        $quit = true;
      else
        print_room($current_room)
        handle_player
      end

    elsif($quit == false)
      puts "\nI don't recognize that command.\nType 'help' to see a list of basic commands."
      handle_player
    end
  end
end
print_room($current_room)
handle_player
