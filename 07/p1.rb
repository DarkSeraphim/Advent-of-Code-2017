require 'set'

carried = Set.new []
carriers = Set.new []


while (line = gets.gsub(/\r|\n/,"")) != "end-of-input" do
  match = /(\w+)\s+\((\d+)\)(?: \-\> (.*))?/.match(line)
  if match
    name = match[1]
    weight = match[2]
    carrying = []
    if match[3]
      carrying = match[3].split(", ")
    end
    puts match[1] << " " << match[2] << ", carrying " << carrying.join(", ")
    
    for c in carrying do
      carried << c
      carriers.delete(c)
    end
    if not carried.include? name
      carriers << name
    end
  end
end

if carriers.length == 1
  puts "Found our carrier: #{carriers.first}"
else
  puts "Multiple carriers found O-o"
end
