a = File.read('21.txt').match /^Player 1 starting position: (?<pos1>\d\d?)\nPlayer 2 starting position: (?<pos2>\d\d?)$/ 
pos1 = a[:pos1].to_i
pos2 = a[:pos2].to_i

def part01(pos1, pos2)
    die = 1
    pos = [pos1, pos2]
    scores = [0, 0]
    current = 0
    die = 0
    until scores[0] >= 1000 || scores[1] >= 1000
        die += 1
        pos[current] += (die - 1) % 100 + 1
        die += 1
        pos[current] += (die - 1) % 100 + 1
        die += 1
        pos[current] += (die - 1) % 100 + 1

        pos[current] = (pos[current] - 1) % 10 + 1
        scores[current] += pos[current]
        current = (current + 1) % 2
    end

    loser = scores[0] >= 1000? 1: 0
    puts scores[loser] * die
end

def count_wins(pos1, pos2, score1, score2, current, die, wins_hash)
    return [0, 1] if score2 >= 21
    return [1, 0] if score1 >= 21
    wins = wins_hash[0]

    val = wins[[pos1, pos2, score1, score2, current, die]] 
    return val unless val.nil?  
    

    if die == 2
        w1 = count_wins((pos1 + (1-current) * 1 - 1) % 10 + 1, (pos2 + current * 1 - 1) % 10 + 1, score1 + (1-current) *((pos1 +  1 - 1) % 10 + 1), score2 + current *((pos2 +  1 - 1) % 10 + 1), 1 - current, 0, [wins])
        w2 = count_wins((pos1 + (1-current) * 2 - 1) % 10 + 1, (pos2 + current * 2 - 1) % 10 + 1, score1 + (1-current) *((pos1 +  2 - 1) % 10 + 1), score2 + current *((pos2 +  2 - 1) % 10 + 1), 1 - current, 0, [wins])
        w3 = count_wins((pos1 + (1-current) * 3 - 1) % 10 + 1, (pos2 + current * 3 - 1) % 10 + 1, score1 + (1-current) *((pos1 +  3 - 1) % 10 + 1), score2 + current *((pos2 +  3 - 1) % 10 + 1), 1 - current, 0, [wins])
    else
        w1 = count_wins((pos1 + (1-current) * 1 - 1) % 10 + 1, (pos2 + current * 1 - 1) % 10 + 1, score1, score2, current, die + 1, [wins])
        w2 = count_wins((pos1 + (1-current) * 2 - 1) % 10 + 1, (pos2 + current * 2 - 1) % 10 + 1, score1, score2, current, die + 1, [wins])
        w3 = count_wins((pos1 + (1-current) * 3 - 1) % 10 + 1, (pos2 + current * 3 - 1) % 10 + 1, score1, score2, current, die + 1, [wins])
    end
    wins[[pos1, pos2, score1, score2, current, die]] = [w1[0] + w2[0] + w3[0], w1[1] + w2[1] + w3[1]]
    return wins[[pos1, pos2, score1, score2, current, die]]
end

def part02(pos1, pos2)
    wins = Hash.new(nil)
    wins1, wins2 = count_wins(pos1, pos2, 0, 0, 0, 0, [wins])
    puts [wins1, wins2].max
end

part01 pos1, pos2
part02 pos1, pos2