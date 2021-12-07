nums = File.read('07.txt').split(',').map(&:to_i).sort!

def part01(nums)
    median = nums[nums.length/2]
    puts( nums.map { |n| (n-median).abs() }.sum )
end

def part02(nums)
    min = nums[nums.length - 1] * nums.length* nums.length
    (0..(nums[nums.length-1] - nums[0]).abs).each do |m|
        value = nums.map {|n| (n - m).abs * ((n - m).abs + 1) / 2  }.sum
        min = value if value < min
    end
    puts min
end

part01(nums)
part02(nums)