lines = File.readlines('10.txt')

def part01(lines)
    sum = 0
    lines.each do |line|
        stack = []
        line.chars.each do |c|
            if ['(', '{', '[', '<'].include? c
                stack << {'(' => ')', '[' => ']', '{' => '}', '<' => '>'}[c]
            elsif [')', '}', ']', '>'].include? c
                if stack[-1] == c
                    stack.pop
                else
                    sum += {')' => 3, ']' => 57, '}' => 1197, '>' => 25137}[c]
                    break
                end
            end
        end
    end

    puts(sum)
end

def part02(lines)
    values = []
    lines.each do |line|
        stack = []
        corrupt = false
        line.chars.each do |c|
            if ['(', '{', '[', '<'].include? c
                stack << {'(' => ')', '[' => ']', '{' => '}', '<' => '>'}[c]
            elsif [')', '}', ']', '>'].include? c
                if stack[-1] == c
                    stack.pop
                else
                    corrupt = true
                    break
                end
            end
        end

        unless corrupt
            val = 0
            until stack.empty?
                c = stack.pop
                val = val * 5 + {')' => 1, ']' => 2, '}' => 3, '>' => 4}[c]
                
            end
            values << val
        end
    end

    puts(values.sort![values.length / 2])
end

part01(lines)
part02(lines)