instructions = {}
line = io.read()
while line ~= "end-of-input" do
  instructions[#instructions + 1] = tonumber(line)
  line = io.read()
end

IP = 1
counter = 0
while #instructions >= IP and IP >= 1 do
  num = instructions[IP]
  instructions[IP] = num + (num >= 3 and -1 or 1)
  IP = IP + num
  counter = counter + 1
end
print(string.format("Took %d steps!", counter))
