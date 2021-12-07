nums = File.read('07.txt').split(',').map(&:to_i).sort!

def part01(nums)
    median = nums[nums.length/2]
    puts( nums.map { |n| (n-median).abs() }.sum )
end

def part02(nums)
    values = []
    (-5..5).each do |k|
        m = mean = (nums.sum / nums.length).floor + k
        values << nums.map {|n| (n - m).abs * ((n - m).abs + 1) / 2  }.sum
    end
    puts values.min
end

part01(nums)
part02(nums)