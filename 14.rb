lines = File.readlines('14.txt')

def count(lines, amount)
    rules = Hash.new
    rules.default = ''
    lines[2..-1].each do |line|
        x, y = line.strip.split(' -> ')
        rules[x] = y 
    end

    start = lines[0].strip
    counts = {}
    counts.default = 0
    
    start.chars.each_cons(2) do |x, y|
        counts[x + y] += 1
    end
    first = start[1..2]

    amount.times do
        temp = {}
        temp.default = 0
        rules.each do |pattern, replace|
            temp[pattern[0] + replace] += counts[pattern]
            temp[replace + pattern[1]] += counts[pattern]
        end
        counts = temp
    end

    character = {}
    character.default = 0
    character[start[0]] = 1
    counts.each do |pattern, count|
        character[pattern[1]] += count
    end
    return character.values.max - character.values.min
end


def part01(lines)
    puts count(lines, 10)
end

def part02(lines)
    puts count(lines, 40)
end

part01(lines)
part02(lines)