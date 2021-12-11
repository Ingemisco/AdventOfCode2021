table = File.readlines('11.txt').map { |line| [0] + line.chars.select {|c| c =~ /\d/}.map{ |c| c.to_i } + [0]}
table.prepend([0] * table[0].length )
table << ([0] * table[0].length )

def part01(table)
    sum = 0
    100.times do 
        additional = []
        reset = []
        (1...table.length-1).each do |i| 
            (1...table[i].length-1).each do |j| 
                table[i][j] += 1
                if table[i][j] == 10
                    additional << [i,j]
                    reset << [i, j]
                end
            end
        end

        

        until additional.empty?
            x, y = additional.pop
            next if x == 0 || y == 0 || x == table[0].length - 1 || y == table.length - 1
            (-1..1).each do |i| 
                (-1..1).each do |j| 
                    table[i+x][j+y] += 1
                    if table[i+x][j+y] == 10
                        additional << [i+x,j+y]
                        reset << [i + x, j+ y]
                    end
                end
            end
            sum += 1
        end

        until reset.empty?
            x, y = reset.pop
            table[x][y] = 0
        end
    end
    puts sum

end


def part02(table)
    counter = 1
    while true do 
        additional = []
        reset = []
        (1...table.length-1).each do |i| 
            (1...table[i].length-1).each do |j| 
                table[i][j] += 1
                if table[i][j] == 10
                    additional << [i,j]
                    reset << [i, j]
                end
            end
        end

        until additional.empty?
            x, y = additional.pop
            next if x == 0 || y == 0 || x == table[0].length - 1 || y == table.length - 1
            (-1..1).each do |i| 
                (-1..1).each do |j| 
                    table[i+x][j+y] += 1
                    if table[i+x][j+y] == 10
                        additional << [i+x,j+y]
                        reset << [i + x, j + y] unless x + i == 0 || y + j == 0 || x + i== table[0].length - 1 || y + j == table.length - 1
                    end
                end
            end
        end
        if reset.size == (table.length-2) * (table[0].length - 2)
            break
        end 
        until reset.empty?

            x, y = reset.pop
            table[x][y] = 0
        end
        counter += 1
    end
    print counter
end

temp = table.map { |l| l.clone }
part01(table)
part02(temp)