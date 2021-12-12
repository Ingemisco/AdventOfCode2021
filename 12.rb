class Graph
    attr_reader :vertices

    def initialize
        @vertices = Hash.new { |h, k| h[k] = [] }
    end

    def add_edge(s, t)
        @vertices[s] << t
    end

    def paths_from(s, t, removed = nil)
        if removed.nil?
            @memo = {}
            a = paths_from(s, t, [])
            @memo = nil
            return a
        elsif (@vertices[s] - removed).empty?
            return 1 if s == t
            return 0
        else
            return @memo[[s, t, removed]] if @memo.has_key?([s, t, removed])
            @memo[[s, t, removed]] = 0
            @memo[[s, t, removed]] += 1 if s == t
            to_remove = []
            to_remove << s if s.downcase == s
            (@vertices[s] - removed).each do |v|
                @memo[[s, t, removed]] += paths_from(v, t, removed + to_remove)
            end
            return @memo[[s, t, removed]]
        end
    end

    def paths_from_one_double(s, t, removed = nil)
        if removed.nil?
            @memo = {}
            r = {}
            r.default = 0
            r[s] = 2
            a = paths_from_one_double(s, t, r)
            @memo = nil
            return a
        elsif ((@vertices[s] - removed.keys).empty? && removed.select { |k, v| v > 1}.size > 1) || s == t
            return 1 if s == t
            return 0
        else
            return @memo[[s, t, removed]] if @memo.has_key?([s, t, removed])
            
            @memo[[s, t, removed]] = 0

            r = removed.clone
            r[s] += 1 if s.downcase == s

            neighbors = @vertices[s] - r.select {|k, v| v > 1}.keys
            neighbors = (@vertices[s] - r.keys) if r.values.select { |v| v > 1}.size > 1

            neighbors.each do |v|
                if v == t
                    @memo[[s, t, removed]] += 1
                else 
                    @memo[[s, t, removed]] += paths_from_one_double(v, t, r)
                end
            end

            @memo[[s, t, removed]] += 1 if s == t
            
            return @memo[[s, t, removed]]
        end
    end

    def self.load_from_file(filename)
        g = Graph.new
        lines = File.readlines(filename)
        lines.each do |line|
            s, t = line.strip.split('-')
            g.add_edge(s, t)
            g.add_edge(t, s)
        end

        return g
    end
end

def part01(graph)
    puts graph.paths_from("start", "end")
end

def part02(graph)
    puts graph.paths_from_one_double("start", "end")
end

g = Graph.load_from_file('12.txt')

part01(g)
part02(g)
