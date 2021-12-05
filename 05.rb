lines = File.readlines('05.txt').map do |line|
    a = line.split(' -> ').map { |x| x.split(',').map(&:to_i) }

    {sx: a[0][0], sy: a[0][1], tx: a[1][0], ty: a[1][1]}
end

def part01(lines)

    points = Hash.new
    points.default = 0

    lines.each do |x|
        if x[:sx] == x[:tx]
            if x[:sy] <= x[:ty]
                (x[:sy]..x[:ty]).each do |i|
                    points[[x[:sx], i]] += 1
                end
            else
                (x[:ty]..x[:sy]).each do |i|
                    points[[x[:sx], i]] += 1
                end
            end
            
        elsif x[:sy] == x[:ty]
            if x[:sx] <= x[:tx]
                (x[:sx]..x[:tx]).each do |i|
                    points[[i, x[:sy]] ] += 1
                end
            else
                (x[:tx]..x[:sx]).each do |i|
                    points[[i, x[:sy]] ] += 1
                end
            end
        end
    end

    overlap = 0
    points.each_value do |i|

        overlap += 1 if i >= 2
    end 

    puts(overlap)
end

part01(lines)