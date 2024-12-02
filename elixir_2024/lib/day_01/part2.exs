defmodule Day01Part2 do
  def run(file_path) do
    file_path
    |> process_input()
    |> calc_scores()
    |> Enum.sum()
    |> IO.puts()
  end

  def process_input(file_path) do
    case File.read(file_path) do
      {:ok, content} ->
        content
        |> process_content()
      {:error, message} ->
        IO.puts(message)
        {[], []}
    end 
  end
  
  def process_content(content) do
    content
    |> String.split("\n", trim: true)
    |> Enum.reduce({[], []}, fn line, {first, second} -> 
      process_line(line, {first, second}) 
    end) 
  end

  def process_line(line, {first, second}) do
    [left, right] = String.split(line, " ", trim: true)
    {[String.to_integer(left) | first], [String.to_integer(right) | second]}
  end

  def calc_scores({first, second}) do
    Enum.map(first, fn x -> 
      x * Enum.count(second, fn y -> x == y end)
    end)
  end
end

Day01Part2.run("./lib/day_01/input.txt")
Day01Part2.run("./lib/day_01/test1.txt")
Day01Part2.run("./lib/day_01/test2.txt")
