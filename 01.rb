lines = File.readlines('01.txt').map(&:to_i)


def count(lines)
    last = :nan
    count = 0
    lines.each do |l|
        if last != :nan and last < l
            count += 1
        end
        last = l
    end
    return count
end


# part 1

def part01(lines)
    puts "count: #{count(lines)}"
end

# part 2

def part02(lines)
    numbers = []

    (0...lines.length - 2).each do |i|
        numbers << lines[i] + lines[i+1] + lines[i+2]
    end

    puts "count: #{count(numbers)}"
end



part01(lines)
part02(lines)