lines = File.readlines('05.txt').map do |line|
    a = line.split(' -> ').map { |x| x.split(',').map(&:to_i) }

    {sx: a[0][0], sy: a[0][1], tx: a[1][0], ty: a[1][1]}
end

def part01(lines)

    points = Hash.new
    points.default = 0

    lines.each do |x|
        if x[:sx] == x[:tx] or x[:sy] == x[:ty]
            dx = (x[:tx] - x[:sx]) <=> 0
            dy = (x[:ty] - x[:sy]) <=> 0

            posx = x[:sx]
            posy = x[:sy]
            points[[posx, posy]] += 1
            until posx == x[:tx] and posy == x[:ty]
                posx += dx
                posy += dy
                points[[posx, posy]] += 1
            end
        end
    end

    overlap = 0
    points.each_value do |i|

        overlap += 1 if i >= 2
    end 

    puts(overlap)
end

def part02(lines)
    points = Hash.new
    points.default = 0

    lines.each do |x|
        dx = (x[:tx] - x[:sx]) <=> 0
        dy = (x[:ty] - x[:sy]) <=> 0

        posx = x[:sx]
        posy = x[:sy]
        points[[posx, posy]] += 1
        until posx == x[:tx] and posy == x[:ty]
            posx += dx
            posy += dy
            points[[posx, posy]] += 1
        end
    end
    
    overlap = 0
    points.each_value do |i|
        overlap += 1 if i >= 2
    end 

    puts(overlap)
end

part01(lines)
part02(lines)