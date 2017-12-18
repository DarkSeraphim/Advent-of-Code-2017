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

  def find_highest(:eof, map) do
    max = Enum.max(Map.values(map))
    IO.puts "The max register is #{max}"
  end

  def find_highest(str, map) do
    if String.trim(str) != "end-of-input" do
      cmd = Regex.named_captures(~r/(?<reg>.*) (?<op>(?:inc|dec)) (?<val>-?\d+) if (?<creg>.*) (?<cop>.{1,2}) (?<cval>-?\d+)/, str)
      map = if check_condition(map, cmd["creg"], cmd["cop"], cmd["cval"]) do
        val = elem((Integer.parse cmd["val"]), 0)
        val = case cmd["op"] do
          "dec" -> -val
          _ -> val
        end
        Map.update(map, cmd["reg"], val, fn cur -> cur + val end)
      else
        map
      end
      find_highest(IO.gets(""), map)
    else 
      find_highest(:eof, map)
    end
  end

  def main do
    find_highest(IO.gets(""), %{})
  end
end

Main.main
