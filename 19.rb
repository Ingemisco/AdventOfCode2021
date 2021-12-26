class Beacon
    attr_reader :x
    attr_reader :y
    attr_reader :z

    def initialize(posx, posy, posz)
        @x = posx
        @y = posy
        @z = posz
    end

    def -(other)
        return Beacon.new(@x - other.x, @y - other.y, @z - other.z)
    end

    def copy
        return Beacon.new(@x, @y, @z)
    end 

    def rotate(r)
        @x, @y, @z = r.call(@x, @y, @z)
    end

    def hash 
        return (@x << 16) ^ (@y << 8) ^ @z
    end

    def dist(other)
        return (@x - other.x).abs + (@y - other.y).abs + (@z - other.z).abs
    end

    def ==(other)
        return @x == other.x && @y == other.y && @z == other.z
    end

    alias eql? ==
end 

class Scanner
    attr_reader :beacons
    attr_reader :distances

    attr_accessor :posx
    attr_accessor :posy
    attr_accessor :posz

    def initialize(beacons)
        @beacons = beacons

        @distances = []
        @beacons.combination(2).each do |x, y|
            @distances << x.dist(y)
        end
    end

    def &(other)
        @beacons.each do |b1|
            p = @beacons.map { |b| b.copy - b1 }
            other.beacons.each do |b2|
                q = other.beacons.map { |b| b.copy - b2 }
                intersection = q & p
                return [b1, b2] if intersection.size >= 12
            end 
        end
        return nil
    end

    def self.from_string(string)
        beacons = string.split(/\n/).map { |line| line.strip.split(',')}.map {|(x,y,z)| Beacon.new(x.to_i, y.to_i, z.to_i)}
        return Scanner.new(beacons)
    end

    def rotate(r)
        @beacons.each do |beacon|
            beacon.rotate(r)
        end
    end

    def copy
        return Scanner.new(@beacons.map &:copy)
    end
end


rotationsXY = [lambda {|x, y, z| [x, y, z]}, lambda {|x, y, z| [y, -x, z]}, lambda {|x, y, z| [-x, -y, z]}, lambda {|x, y, z| [-y, x, z]}]
rotationsZ = [lambda {|x, y, z| [x, y, z]}, lambda {|x, y, z| [z, y, -x]}, lambda {|x, y, z| [-x, y, -z]}, lambda {|x, y, z| [-z, y, x]}, 
    lambda {|x, y, z| [x, z, -y]}, lambda {|x, y, z| [x, -z, y]}]

$rotations = []
rotationsXY.each do |r|
    rotationsZ.each do |s| 
        $rotations << lambda {|x, y, z| r.call(*s.call(x,y,z))}
    end 
end

def match(scanners)
    scanner0 = scanners.shift
    scanner0.posx = 0
    scanner0.posy = 0
    scanner0.posz = 0
    queue = [scanner0]
    result = []
    until queue.empty?
        scanner = queue.shift
        to_remove = []
        d1 = scanner.distances
        
        scanners.each do |s|
            d2 = s.distances
            n = scanner.beacons.length
            next if d1.length - n * (n-1) / 2 + (d1 & d2).length < 66

            $rotations.each do |r|
                t = s.copy
                t.rotate(r)

                intersection = scanner & t
                unless intersection.nil?
                    queue << t
                    t.posx = scanner.posx + intersection[0].x - intersection[1].x
                    t.posy = scanner.posy + intersection[0].y - intersection[1].y
                    t.posz = scanner.posz + intersection[0].z - intersection[1].z
                    to_remove << s
                    break
                end
            end
        end
        scanners -= to_remove
        to_remove.clear
        result << scanner
    end

    return result
end

def beacon_positions(scanners)
    positions = Hash.new(false)
    scanners.each do |s|
        s.beacons.each do |b| 
            positions[[b.x + s.posx, b.y + s.posy, b.z + s.posz]] = true
        end
    end
    return positions
end

def part01(scanners)
    scanners = match(scanners)
    positions = beacon_positions(scanners)
    puts positions.values.length
    return scanners
end

def part02(scanners)
    maxdist = 0
    scanners.combination(2).each do |s, t|
        dist = (s.posx - t.posx).abs + (s.posy - t.posy).abs + (s.posz - t.posz).abs
        maxdist = dist if dist > maxdist
    end
    puts maxdist
end


scanners = File.read('19.txt').split(/--- scanner \d+ ---/).map( &:strip).select {|s| !s.empty?}.map {|s| Scanner.from_string(s)} 

scanners = part01 scanners
part02 scanners









