def game_of_threes( x )
  while x > 1
    modulo = x % 3
    case modulo
    when 0
      puts x.to_s + " 0"
      x = x / 3 
    when 1
      puts x.to_s + " -1"
      x = (x - 1) / 3
    when 2
      puts x.to_s + " 1"
      x = (x + 1) / 3
    end
  end
  puts x
end

if __FILE__ == $PROGRAM_NAME
  game_of_threes( gets.chomp.to_i )
end
