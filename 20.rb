input = File.readlines('20.txt')
$algorithm = Hash.new{|h, k| h[k] = input[0][k] == '#' ? 1: 0 }

image = input[2..-1].map { |line| line.strip }

def iterate(image, steps)
    m = image.length
    n = image[0].length
    table = Hash.new{|h, (y,x)| h[[y,x]] = (0 <= x && x < n && 0 <= y && y < m && image[y][x]) == '#' ? 1: 0}
    steps.times do |i|
        temp = Hash.new{ |h, (y,x)| h[[y,x]] = i.even? ? $algorithm[0]: 0 }
        (-i-1).upto(m+i+1).each do |y|
            (-i-1).upto(n+i+1).each do |x| 
                val = table[[y+1, x+1]] + 2 * table[[y+1, x]] + 4 * table[[y+1, x-1]]
                val += 8 * table[[y, x+1]] + 16 * table[[y, x]] + 32 * table[[y, x-1]]
                val += 64 * table[[y-1, x+1]] + 128 * table[[y-1, x]] + 256 * table[[y-1, x-1]]

                temp[[y, x]] = $algorithm[val]
            end
        end
        table = temp
    end

    return table
end 

def part01(image)
    puts iterate(image, 2).values.select {|i| i == 1}.length
end

def part02(image)
    puts iterate(image, 50).values.select {|i| i == 1}.length
end

part01(image)
part02(image)