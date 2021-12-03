lines = File.readlines('03.txt').map { |line| line.chars }

def part01(lines)
    gamma = []
    epsilon = []
    (lines[0].length-1).times do |i|
        zeros = lines.select { |line| line[i] == '0' }.length
        ones = lines.length - zeros

        if zeros > ones
            gamma << 0
            epsilon << 1
        else
            epsilon << 0
            gamma << 1
        end

    end

    puts(gamma.join.to_i(2) * epsilon.join.to_i(2))
end

def part02(lines)
    oxy = lines
    i = 0
    until oxy.size == 1 do
        zeros = oxy.select { |line| line[i] == '0'}.length

        if zeros > oxy.length - zeros 
            oxy = oxy.select { |line| line[i] == '0'}
        else
            oxy = oxy.select { |line| line[i] == '1'}
        end
        i +=1
    end

    co2 = lines
    i = 0
    until co2.size == 1 do
        zeros = co2.select { |line| line[i] == '0'}.length

        if zeros <= co2.length - zeros 
            co2 = co2.select { |line| line[i] == '0'}
        else
            co2 = co2.select { |line| line[i] == '1'}
        end
        i +=1
    end

    puts(oxy.join.to_i(2) * co2.join.to_i(2))
end

part01(lines)
part02(lines)
