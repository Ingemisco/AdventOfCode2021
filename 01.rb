lines = File.readlines('01.txt').map(&:to_i)

def count(lines)
    count = 0
    lines.each_cons(2) do |l, k|
        count += 1 if l < k
    end
    return count
end

def part01(lines)
    puts "count: #{count(lines)}"
end

def part02(lines)
    numbers = []

    lines.each_cons(3) do |i, j, k|
        numbers << i + j + k
    end

    puts "count: #{count(numbers)}"
end

part01(lines)
part02(lines)