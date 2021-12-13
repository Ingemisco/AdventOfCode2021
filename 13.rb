lines = File.readlines('13.txt')

def process(lines, stop_after_first)
    map = {}
    map.default = false

    lines.each do |line|
        if m = line.match(/^(?<first>\d+),(?<second>\d+)$/)
            x = m[:first].to_i
            y = m[:second].to_i

            map[[x,y]] = true
        elsif m = line.match(/^fold along (?<axis>[xy])=(?<val>\d+)$/)
            fold_x = m[:axis] == 'x'
            fold_y = m[:axis] == 'y'

            val = m[:val].to_i

            fold = lambda do |x, y|
                if x > val && fold_x
                    return 2 * val -x , y
                elsif y > val && fold_y
                    return x, 2 * val - y 
                else 
                    return x, y
                end
            end

            temp = {}
            temp.default = false
            map.each do |(x, y), val|
                nx, ny = fold.call(x, y)

                temp[[nx, ny]] = temp[[nx, ny]] || map[[x, y]]
            end
            map = temp
            break if stop_after_first
        end
    end

    return map
end

def print_map(map)
    maxx = map.keys.max {|(x,y),(x2,y2)| x <=> x2}[0]
    maxy = map.keys.max {|(x,y),(x2,y2)| y <=> y2}[1]
    (0..maxy).each do |y|
        (0..maxx).each do |x|
            if map[[x,y]]
                print '#'
            else 
                print ' '
            end
        end
        puts
    end
end

def part01(lines)
    map = process(lines, true)
    puts map.select {|k, v| v}.length
end

def part02(lines)
    map = process(lines, false)
    print_map(map)
end

part01(lines)
part02(lines)