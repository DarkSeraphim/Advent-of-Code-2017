defmodule Main do
  def check_condition(map, reg, op, v) do
    rv = Map.get(map, reg, 0)
    val = elem((Integer.parse v), 0)
    case op do
      ">" -> rv > val
      "<" -> rv < val
      ">=" -> rv >= val
      "<=" -> rv <= val
      "==" -> rv == val
      "!=" -> rv != val
      _ -> raise "Unknown operator"
    end
  end

  def find_highest(:eof, map, highest) do
    max = Enum.max(Map.values(map))
    IO.puts "The max register is #{max}"
    IO.puts "The all time highest is #{highest}"
  end

  def find_highest(str, map, highest) do
    if String.trim(str) != "end-of-input" do
      cmd = Regex.named_captures(~r/(?<reg>.*) (?<op>(?:inc|dec)) (?<val>-?\d+) if (?<creg>.*) (?<cop>.{1,2}) (?<cval>-?\d+)/, str)
      {map, highest} = if check_condition(map, cmd["creg"], cmd["cop"], cmd["cval"]) do
        val = elem((Integer.parse cmd["val"]), 0)
        val = case cmd["op"] do
          "dec" -> -val
          _ -> val
        end
        map = Map.update(map, cmd["reg"], val, fn cur -> cur + val end)
        val = map[cmd["reg"]]
        highest = if val > highest do val else highest end
        {map, highest}
      else
        {map, highest}
      end
      find_highest(IO.gets(""), map, highest)
    else 
      find_highest(:eof, map, highest)
    end
  end

  def main do
    find_highest(IO.gets(""), %{}, 0)
  end
end

Main.main
