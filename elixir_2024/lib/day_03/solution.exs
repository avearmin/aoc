defmodule Day03 do
  def run_part1(input) do
    input
    |> File.read!()
    |> clean_input()
    |> extract_nums()
    |> mul_pairs()
    |> Enum.sum()
    |> IO.inspect()
  end

  def run_part2(input) do
    input
    |> File.read!()
    |> clean_input_dont()
    |> IO.inspect()
    |> extract_nums()
    |> mul_pairs()
    |> Enum.sum()
    |> IO.inspect()
  end

  def clean_input(input) do
    Regex.scan(~r/mul\(-?\d+,-?\d+\)/, input) |> List.flatten()
  end
  
  def clean_input_dont(input) do
    Regex.scan(~r/^(?:.?|do\(\)|)(?:.?)mul\(-?\d+,-?\d+\)(?:.?)(?:dont\(\)|do\(\)|.?)$/, input) |> List.flatten()
  end

  def extract_nums(cleaned_input) do
    Enum.map(cleaned_input, fn x -> 
      Regex.scan(~r/-?\d+/, x) 
    end)
    |> List.flatten()
    |> Enum.map(fn x -> String.to_integer(x) end)
  end
   
  def mul_pairs([one]), do: [one]
  def mul_pairs([one, two]), do: [one * two]
  def mul_pairs([one, two | rest]) do
    [one * two | mul_pairs(rest)]
  end
end

Day03.run_part1("./lib/day_03/input.txt")
Day03.run_part2("./lib/day_03/input.txt")
