lines = File.read('04.txt').split("\n\n")


class Bingo
    def initialize(bingo)
        @field = []
        
        bingo.split("\n").each do |line|
            @field << line.split(" ").map(&:to_i)
        end

        @nums = Hash.new
        @nums.default = false
        (0..4).each do |i|
            (0..4).each do |j|
                @nums[@field[i][j]] = {i: i, j: j}
            end
        end

    end

    def num_to_end(nums)
        bools = Array.new(5).map{ Array.new(5).map { false } }
        rounds = 0
        nums.each do |n|
            rounds += 1
            a = @nums[n]
            if a
                i = a[:i]
                j = a[:j]

                bools[i][j] = true
                if (bools[0][j] and bools[1][j] and bools[2][j] and bools[3][j] and bools[4][j]) or (bools[i][0] and bools[i][1] and bools[i][2] and bools[i][3] and bools[i][4])
                    sum = 0
                    (0..4).each do |k|
                        (0..4).each do |l|
                            unless bools[k][l]
                                sum += @field[k][l]
                            end
                        end
                    end
                    
                    return {round: rounds, val: sum * n}
                end
            end
        end

        return :inf
    end 


    def to_s
        return @field.to_s
    end

end

def part01(lines)
    numbers = lines[0].split(",").map(&:to_i)

    bingos = []
    
    lines[1...lines.length].each do |field|
        bingos << Bingo.new(field)
    end
    
    min = {round: :inf}
    
    bingos.each do |bingo|
        temp = bingo.num_to_end(numbers)
        if min[:round] == :inf or temp[:round] < min[:round]
            min = temp
        end
    end

    puts(min[:val])

end

def part02(lines)

end


part01(lines)