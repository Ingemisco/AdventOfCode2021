match = File.read('17.txt').match /^target area: x=(?<xfrom>-?\d+)\.\.(?<xto>-?\d+), y=(?<yfrom>-?\d+)\.\.(?<yto>-?\d+)/
xfrom = match[:xfrom].to_i
xto = match[:xto].to_i
yfrom = match[:yfrom].to_i
yto = match[:yto].to_i

def part01(xfrom, xto, yfrom, yto)
    y = -yfrom - 1
    return y * (y + 1)/2
end

def part02(xfrom, xto, yfrom, yto)
    count = 0

    min_x = (-0.5 + Math.sqrt(2 * xfrom + 0.25)).ceil
    max_x = xto

    min_x.upto(max_x) do |x|
        yfrom.upto(-yfrom).each do |y|
            count += 1 unless (1..(-2*(yfrom - 1))).to_a.map {|t| calculate_position(x, y, t)}.select {|px, py| xfrom <= px && px <= xto && yfrom <= py && py <= yto}.empty?
        end
    end
    return count
end

def calculate_position(x, y, t)
    t2 = [x, t].min
    px = t2 * x - t2 * (t2 - 1) / 2
    py = t * y - t * (t - 1) / 2
    return [px, py]
end

puts part01(xfrom, xto, yfrom, yto)
puts part02(xfrom, xto, yfrom, yto)