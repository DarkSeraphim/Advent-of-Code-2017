require 'set'

own = {}
weights = {}
# I'm lazy, I know
unresolved = {}
children = {}
nodes = []

while (line = gets.gsub(/\r|\n/,"")) != "end-of-input" do
  match = /(\w+)\s+\((\d+)\)(?: \-\> (.*))?/.match(line)
  if match
    name = match[1]
    nodes << name
    weight = match[2].to_i
    own[name] = weight
    if match[3]
      carrying = match[3].split(", ")
      unresolved[name] = children[name] = carrying
    else
      weights[name] = weight
    end
  end
end
puts "B"
root = nil
# Resolve all weights, find root
while unresolved.length > 0 do
  unresolved.delete_if do |key, value|
    ws = value.map {|name| weights[name]}
    # If all weights are known
    known = !ws.any? {|e| e.nil?}
    if known
      weights[key] = own[key] + ws.inject(0){|sum,x| sum + x }
      if root.nil? or weights[root] < weights[key]
        root = key
      end
    end
    known
  end
end
wrongs = []

nodes.each {|node|
  cn = children[node]
  if cn == nil or cn.length < 2
    next # Can hardly be wrong
  elsif cn.length == 2
    if weights[cn[0]] != weights[cn[1]]
      wrongs << "#{cn[0]} and #{cn[1]} were bad?"
    end
  else
    if weights[cn[0]] == weights[cn[1]]
      no = cn.select do |e|
        weights[e] != weights[cn[0]]
      end
      if no.length == 0
        puts "Node #{node} itself seems to be ok"
      else
        wrongs << "#{no.first} with value #{weights[no.first]} vs #{weights[cn[0]]}"
      end
    else 
      # 1 is the odd one
      if weights[cn[0]] == weights[cn[2]] 
        check = cn[1]
        diff = weights[cn[0]] - weights[cn[1]]
        wrongs << "#{check} should have #{own[check] + diff}"
      # 0 is the odd one
      else
        check = cn[0]
        diff = weights[cn[1]] - weights[cn[0]]
        wrongs << "#{check} should have #{own[check] + diff}"
      end
    end
  end
}

# Pick minimum?
puts wrongs.join(", ")
