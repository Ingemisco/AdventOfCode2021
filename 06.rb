numbers = File.read('06.txt').split(',').map(&:to_i)

def cycle(numbers, length)
    fish = [0, 0, 0, 0, 0, 0, 0]
    non_mature = [0, 0, 0, 0, 0, 0, 0]

    numbers.each do |n|
        if n < 7
            fish[n] += 1 
        else
            non_mature[(n + 2) % 7] += 1
        end
    end

    pointer = 0
    length.times do 
        temp = fish[pointer]
        fish[pointer] += non_mature[pointer]
        non_mature[pointer] = 0
        non_mature[(pointer + 2) % 7] = temp
        pointer = (pointer + 1) % 7
    end

    return fish.sum + non_mature.sum
end

def part01(numbers)
    puts(cycle(numbers, 80))
end

def part02(numbers)
    puts(cycle(numbers, 256))
end

part01(numbers)
part02(numbers)