require 'pry'

puts 'Hi, welcome to the blackjack game! What\'s your name?'
name = gets.chomp
puts "Welcome #{name}!, let\'s start the game!"#用了#{}就一定要用""？

#發牌
def get_card(cards)
	card_index = rand(cards.count) - 1
	card = cards[card_index]
	cards.delete_at(card_index)
	card
end

def output_card(name,cards)
  puts "#{name}'s card: " + cards.join(', ')
  # puts cards
end

#算牌
def count_card(cards)
  total = 0
  # have_A = 0
  cards.each do |c|
    # puts c
    case c
    # when "A"
    #   have_A += 1      
    when "J","Q","K"
      total += 10
    else
      total += c.to_i
    end
  end

  # have_A.times do
  cards.select{|c| c == "A"}.count.times do
    if total + 11 <= 21
      total += 11
    else
      total += 1
    end    
  end

  total
end

#一局開始
while true

  #總共有多少牌？
  cards = ["A","A","A","A",
           "2","2","2","2",
           "3","3","3","3",
           "4","4","4","4",
           "5","5","5","5",
           "6","6","6","6",
           "7","7","7","7",
           "8","8","8","8",
           "9","9","9","9",
           "10","10","10","10",
           "J","J","J","J",
           "Q","Q","Q","Q",
           "K","K","K","K"]

	#先各發兩張
	player = []
	dealer = []

  puts
  puts "--- Get Two Cards ---"

	#first card
	player.push(get_card(cards))	
	dealer.push(get_card(cards))
	#second card
	player.push(get_card(cards))	
	dealer.push(get_card(cards))

  output_card("player",player)
  output_card("dealer",dealer)

  player_total = count_card(player)
  dealer_total = count_card(dealer)

  #玩家先
  puts
  puts "--- Player's turn ---"
  while true
    puts
    puts 'Want to hit(H) or stay(S)?'
    action = gets.chomp.upcase
    if action == 'H'
      card = get_card(cards)
      player.push(card)
      player_total = count_card(player)
      # binding.pry

      puts "=> You get [#{card}], total is " + player_total.to_s
      output_card("player",player)

    elsif action == 'S'
      break
    else
      next
    end
  end

  if player_total == 21
    puts
    puts "*** BlackJack!! You WIN! ***"
    puts
  elsif player_total > 21
    puts
    puts "*** Busted! You LOST! ***"
    puts  
  else
    #換莊家：不詢問，發到結束
    puts
    puts "--- Dealer's turn ---"
    while true
          
      if dealer_total == 21
        puts
        puts "*** BlackJack!! Dealer WIN! ***"
        puts
        break
      elsif dealer_total > 21
        puts
        puts "*** Busted! You WIN! ***"
        puts
        break
      elsif dealer_total >= 17
        puts
        puts "Compare result, Palyer got " + player_total.to_s +
             ", Dealer got " + dealer_total.to_s + "."

        if player_total > dealer_total
          puts "*** Player WIN! ***"
        elsif player_total < dealer_total
          puts "*** Dealer WIN! You LOST! ***"
        else
          puts "*** Even! ***"
        end

        break
      else
        card = get_card(cards)
        dealer.push(card)
        dealer_total = count_card(dealer)
        # binding.pry

        puts "=> Dealer get [#{card}], total is " + dealer_total.to_s
        output_card("dealer",dealer)
      end

    end  
  end
  
  # output_card("player",player)

  puts "--- End ---"
  puts "Again?(Y/N)"
  action = gets.chomp.upcase

  break if action == "N"
  # if action == "N"
  #   break
  # end
end




