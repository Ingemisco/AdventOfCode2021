input = File.read('16.txt').strip
length = input.length
input = input.to_i(16).to_s(2).rjust(length * 4, '0')

def parse(input)
    version = input[0...3].to_i(2)
    type = input[3...6].to_i(2)

    if type == 4
        block_amount = 0
        while input[6 + 5 * block_amount] != "0"
            block_amount += 1
        end
        block_amount += 1 

        num = input[6... 6 + 5 * block_amount].chars.select.with_index { |_, i| i % 5 != 0}.reduce(""){ |sum, val| sum + val.to_s}.to_i(2)
        return {version: version, type: type, val: num, length: 6 + block_amount * 5}
    else
        packets = []
        if input[6] == "0"
            length = input[7...22].to_i(2)
            packet_start = 22
            while packet_start < length + 22
                packet = parse(input[packet_start..-1])
                packets << packet
                packet_start += packet[:length]
            end

            return {version: version, type: type, val: packets, length: 22+length }
        else
            packet_amount = input[7...18].to_i(2)
            
            packet_start = 18
            packet_amount.times do
                packet = parse(input[packet_start..-1])
                packets << packet
                packet_start += packet[:length]
            end

            return {version: version, type: type, val: packets, length: packet_start}
        end
    end
end

def part01(packet)
    return packet[:version] if packet[:type] == 4
    return packet[:val].reduce(packet[:version]){|sum, val| sum + part01(val)}
end

def part02(packet)
    return packet[:val] if packet[:type] == 4
    subpackets = packet[:val].map {|p| part02(p)}
    case packet[:type]
    in 0
        return subpackets.sum
    in 1
        return subpackets.reduce :*
    in 2
        return subpackets.min
    in 3
        return subpackets.max
    in 5
        return subpackets[0] > subpackets[1] ? 1: 0
    in 6
        return subpackets[0] < subpackets[1] ? 1: 0
    in 7
        return subpackets[0] == subpackets[1] ? 1: 0 
    end
end

packet = parse(input)

puts part01(packet)
puts part02(packet)

