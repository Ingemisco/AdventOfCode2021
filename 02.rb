lines = File.readlines('02.txt').map { |line| { operation: line.split(' ')[0], value: line.split(' ')[1].to_i } }


def part01(lines)
    hor = 0
    dep = 0

    lines.each do |line|
        case line
        in {operation: 'forward', value: value}
            hor += value
        in {operation: 'up', value: value}
            dep -= value
        in {operation: 'down', value: value}
            dep += value
        else
            puts(operation)
        end
    end

    puts(hor * dep)
end

def part02(lines)
    hor = 0
    dep = 0
    aim = 0

    lines.each do |line|
        case line
        in {operation: 'forward', value: value}
            hor += value
            dep += aim * value
        in {operation: 'up', value: value}
            aim -= value
        in {operation: 'down', value: value}
            aim += value
        else
            puts(operation)
        end
    end

    puts(hor * dep)
end

part01(lines)
part02(lines)