grid = File.readlines('15.txt').map{ |line| line.strip.chars.map(&:to_i)}

# for some reasons ruby does not have a priority queue...
class PQ
    def initialize(cmp)
        @heap = []
        @cmp = cmp
    end

    def insert value
        index = @heap.size
        @heap << value
        while index > 0 && @cmp.call(@heap[index / 2], @heap[index]) > 0
            temp = @heap[index]
            @heap[index] = @heap[index / 2]
            @heap[index / 2] = temp
            index /= 2
        end
    end
    
    def extract_min
        return nil if @heap.empty?
        value = @heap[0]

        last = @heap.pop
        
        return value if @heap.empty?

        @heap[0] = last
        index = 0
        
        while 2 * index < @heap.length
            greater = index
            greater = 2 * index if @cmp.call(@heap[index], @heap[2 * index]) > 0
            greater = 2 * index + 1 if 2 * index + 1 < @heap.length && @cmp.call(@heap[greater], @heap[2 * index + 1]) > 0
            break if index == greater
            temp = @heap[index]
            @heap[index] = @heap[greater]
            @heap[greater] = temp
            index = greater
        end

        return value
    end

    def empty?
        return @heap.empty?
    end

    def to_s
        return @heap.to_s
    end

    alias_method :<<, :insert 
end

def dijkstra(grid, sx, sy, tx, ty)
    queue = PQ.new lambda {|(val0, _), (val1, _)| val0<=> val1}
     
    

    queue << [0, [sy, sx]]

    visited = Hash.new(false)
    visited[[sy, sx]] = true

    until queue.empty?
        v, pos = queue.extract_min
        y, x = pos

        return v if x == tx && y == ty

        queue << [v + grid[y][x-1], [y, x-1]] if x > 0 && !visited[[y, x-1]]
        queue << [v + grid[y][x+1], [y, x+1]] if x < tx && !visited[[y, x+1]]
        queue << [v + grid[y-1][x], [y-1, x]] if y > 0 && !visited[[y-1, x]]
        queue << [v + grid[y+1][x], [y+1, x]] if y < ty && !visited[[y+1, x]]
        visited[[y, x-1]] = true
        visited[[y, x+1]] = true
        visited[[y+1, x]] = true
        visited[[y-1, x]] = true

    end
end

def part01(grid)
    ty = grid.length - 1
    tx = grid[0].length - 1
    puts dijkstra(grid, 0, 0, tx, ty)
end

def part02(grid)
    m = grid.length
    n = grid[0].length
    grid2 = Array.new(5 * m)
    (0...5).each do |i|
        (0...m).each do |k|
            grid2[m * i + k] = Array.new(5 * n)
            (0...5).each do |j|            
                (0...n).each do |l|

                    grid2[i * m + k][j * n + l] = (grid[k][l] - 1+ i + j) % 9 + 1
                end
            end
        end
    end

    ty = grid2.length - 1
    tx = grid2[0].length - 1
    puts dijkstra(grid2, 0, 0, tx, ty)
end

puts part01(grid)
part02(grid)
