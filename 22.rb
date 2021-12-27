class Cuboid
    attr_reader :xfrom
    attr_reader :xto
    attr_reader :yfrom
    attr_reader :yto
    attr_reader :zfrom
    attr_reader :zto

    def initialize(xfrom, xto, yfrom, yto, zfrom, zto)
        @xfrom = xfrom
        @xto = xto
        @yfrom = yfrom
        @yto = yto
        @zfrom = zfrom
        @zto = zto
    end

    def & other
        return Cuboid.new([@xfrom, other.xfrom].max, [@xto, other.xto].min, [@yfrom, other.yfrom].max, [@yto, other.yto].min, [@zfrom, other.zfrom].max, [@zto, other.zto].min)
    end

    def volume
        return 0 if @xto < @xfrom || @yto < @yfrom || @zto < @zfrom
        return (@xto - @xfrom) * (@yto - @yfrom) * (@zto - @zfrom)
    end
end

def count lines
    pos_cubes = []
    neg_cubes = []

    lines.each do |line|
        to_add = []
        to_remove = []

        cuboid = Cuboid.new(line[:xfrom], line[:xto], line[:yfrom], line[:yto], line[:zfrom], line[:zto])

        if line[:state] == "on"
            to_add << cuboid
        end

        pos_cubes.each do |c|
            intersection = cuboid & c
            to_remove << intersection if intersection.volume > 0
        end
        neg_cubes.each do |c|
            intersection = cuboid & c
            to_add << intersection if intersection.volume > 0
        end

        pos_cubes += to_add
        neg_cubes += to_remove
    end

    return pos_cubes.reduce(0) { |sum, c| sum + c.volume} - neg_cubes.reduce(0) { |sum, c| sum + c.volume}
end

def part01(lines)
    lines = lines.select { |line| line[:xfrom] >= -50 && line[:xfrom] <= 50 && line[:yfrom] >= -50 && line[:yfrom] <= 50 && line[:zfrom] >= -50 && line[:zfrom] <= 50}
    lines = lines.select { |line| line[:xto] >= -50 && line[:xto] <= 50 && line[:yto] >= -50 && line[:yto] <= 50 && line[:zto] >= -50 && line[:zto] <= 50}
    
    puts count lines
end

def part02 lines
    puts count lines
end

lines = File.readlines("22.txt").map do |line|
    a = line.match /^(?<state>on|off) x=(?<xfrom>-?\d+)\.\.(?<xto>-?\d+),y=(?<yfrom>-?\d+)\.\.(?<yto>-?\d+),z=(?<zfrom>-?\d+)\.\.(?<zto>-?\d+)$/ 
    {state: a[:state], xfrom: a[:xfrom].to_i, yfrom: a[:yfrom].to_i, zfrom: a[:zfrom].to_i, xto: a[:xto].to_i+1, yto: a[:yto].to_i+1, zto: a[:zto].to_i+1}
end

part01 lines
part02 lines