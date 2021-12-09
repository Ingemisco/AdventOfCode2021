lines = File.readlines('09.txt')
grid = []
j = 0
lines.each do |line|
    grid << []
    line.chars.each do |i|
        grid[j] << i.to_i if i =~ /^\d$/
    end
    j += 1
end

def part01(grid)
    res = 0
    (0...grid.length).each do |y|
        (0...grid[y].length).each do |x|
            if grid[y][x] < [[0,-1], [0,1], [-1,0], [1,0]].select { |s, t| s + y >= 0 && s + y < grid.length && t + x >= 0 && t + x < grid[y].length}.map { |s,t| grid[y+s][x+t] }.min
                res += grid[y][x] + 1
            end
        end
    end
    puts(res)
end


def part02(grid)
    covered = Hash.new(false)

    sizes = []
    (0...grid.length).each do |y|
        (0...grid[y].length).each do |x|
            next if covered[[y, x]] || grid[y][x] == 9
            stack = [[y,x]]
            size = 0
            until stack.empty?
                s,t = stack.pop
                next if s < 0 || t < 0 || s >= grid.length || t >= grid[s].length || grid[s][t] == 9 || covered[[s,t]]
                covered[[s,t]] = true
                stack << [s-1,t]
                stack << [s+1,t]
                stack << [s,t-1]
                stack << [s,t+1]
                size += 1
            end

            sizes << size
        end
    end
    sizes = sizes.sort!
    puts(sizes[-1] * sizes[-2] * sizes[-3])
end

part01(grid)
part02(grid)