lines = File.readlines('08.txt')


def part01(lines)
    occurences = 0
    lines.each do |line|
        occurences += line.split('|')[1].split(' ').select { |n| [2, 3, 4, 7].include?(n.size) }.size
    end
    puts(occurences)
end

def part02(lines)
    sum = 0
    lines.each do |line|
        nums, code = line.split('|').map { |x| x.split(' ').map{|y| y.chars.sort.join('')} }
        one = nums.select { |x| x.length == 2}[0]
        four = nums.select { |x| x.length == 4}[0]
        seven = nums.select { |x| x.length == 3}[0]
        eight = nums.select { |x| x.length == 7}[0]

        red = nums.select { |x| ![one, four, seven, eight].include?(x) }

        a = (seven.chars - one.chars)[0]
        b = "abcdefg".chars.select { |x| nums.select { |y| y.include?(x)}.size == 6 }[0]
        c = "abcdefg".chars.select { |x| nums.select { |y| y.include?(x)}.size == 8 && x != a }[0]
        e = "abcdefg".chars.select { |x| nums.select { |y| y.include?(x)}.size == 4 }[0]
        f = "abcdefg".chars.select { |x| nums.select { |y| y.include?(x)}.size == 9 }[0]
        d = "abcdefg".chars.select { |x| four.include?(x) && ![b, c, f].include?(x) }[0]
        g = ("abcdefg".chars - [a,b,c,d,e,f])[0]

        zero = [a,b,c,e,f,g].sort.join("")
        two = [a,c,d,e,g].sort.join("")
        three = [a,c,d,f,g].sort.join("")
        five = [a,b,d,f,g].sort.join("")
        six = [a,b,d,e,f,g].sort.join("")
        nine = [a,b,c,d,f,g].sort.join("")

        sum +=  code.map{ |c| {one => 1, two => 2, three => 3, four => 4, five => 5, six => 6, seven => 7, eight => 8, nine => 9, zero => 0}[c]}.join("").to_i
    end
    puts(sum)
end

part01(lines)
part02(lines)