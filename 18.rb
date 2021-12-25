class SnailFishNumber
    attr_accessor :left
    attr_accessor :right

    attr_accessor :val
    attr_accessor :next_left
    attr_accessor :next_right
    attr_accessor :parent

    def initialize(v, w=nil)
        @nextleft = nil
        @nextright = nil
        @parent = nil
        @val = nil

        if w.nil?
            @val = v
        else 
            @left = v
            @right = w
            
            lm = @left.rightmost
            rm = @right.leftmost
            lm.next_right = rm
            rm.next_left = lm

            @left.parent = self
            @right.parent = self
        end
    end

    def +(other)
        return other.copy if self == NEUTRAL
        return self.copy if other == NEUTRAL
        res = SnailFishNumber.new(self.copy, other.copy)
        res.reduce
        
        return res
    end

    def copy
        return SnailFishNumber.new(@val) unless @val.nil?
        return SnailFishNumber.new(@left.copy, @right.copy) 
    end

    def leftmost
        return self if @left.nil?
        return @left.leftmost
    end

    def rightmost
        return self if @right.nil?
        return @right.rightmost
    end

    def reduce
        loop do
            node = node_of_depth(4)
            if node.nil?
                node = node_of_val(10)
                if node.nil?
                    break
                else 
                    node.split
                end
            else 
                node.explode
            end
        end
    end

    def node_of_depth(d)
        return self if d == 0 && @val.nil?
        return nil if @right.nil? && @left.nil?
        
        node = @left.node_of_depth(d-1) unless @left.nil?
        return node unless node.nil?
        return nil if @right.nil?
        return @right.node_of_depth(d-1)
    end

    def node_of_val(v)
        return self if @left.nil? && @right.nil? && @val >= v
        return nil if @right.nil? && @left.nil?
        
        node = @left.node_of_val(v) unless @left.nil?
        return node unless node.nil?
        return nil if @right.nil?
        return @right.node_of_val(v)
    end

    def explode
        left_val = @left.val
        right_val = @right.val

        @left.next_left.val += left_val unless @left.next_left.nil?
        @right.next_right.val += right_val unless @right.next_right.nil?
        
        @val = 0
        @next_right = @right.next_right
        @next_left = @left.next_left
        @next_right.next_left = self unless @next_right.nil?
        @next_left.next_right = self unless @next_left.nil?
        @left = nil
        @right = nil

    end

    def split
        left_val = @val / 2
        right_val = @val - left_val

        node = SnailFishNumber.new(SnailFishNumber.new(left_val), SnailFishNumber.new(right_val))

        @next_left.next_right = node.left unless @next_left.nil?
        @next_right.next_left = node.right unless @next_right.nil?
        node.left.next_left = @next_left
        node.right.next_right = @next_right

        node.parent = @parent
        @parent.left = node if @parent.left == self
        @parent.right = node if @parent.right == self
    end

    def self.from_array(array)
        return SnailFishNumber.new(array) unless array.is_a?(Array)
        left = SnailFishNumber.from_array(array[0])
        right = SnailFishNumber.from_array(array[1])
        return SnailFishNumber.new(left, right)
    end

    def to_s
        return "#{@val}" if @left.nil? && @right.nil?
        return "[#{@left.to_s}, #{@right.to_s}]"
    end

    def magnitude
        return @val unless @val.nil?
        return 3 * @left.magnitude + 2 * @right.magnitude
    end

    NEUTRAL = SnailFishNumber.new(:neutral)
end

def part01(nums)
    num = nums.reduce(SnailFishNumber::NEUTRAL) {|sum, val| sum + val}
    puts num.magnitude
end

def part02(nums)
    max = 0
    nums.permutation(2) do |(x, y)|
        val = (x + y).magnitude
        max = val if max < val
    end
    puts max
end

nums = File.readlines('18.txt').map { |l| SnailFishNumber.from_array(eval l) }

part01 nums
part02 nums