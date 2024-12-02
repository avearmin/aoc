defmodule Day01Part1 do
  def run(file_path) do
    file_path
    |> process_input()
    |> sort_lists()
    |> zip_lists_then_diff()
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

  def sort_lists({first, second}) do
    {Enum.sort(first), Enum.sort(second)} 
  end

  def zip_lists_then_diff({first, second}) do
      Enum.zip_reduce(first, second, [], fn left, right, acc -> 
        diff = Enum.max([left, right]) - Enum.min([left, right])
        [diff] ++ acc
    end)
  end
 end

Day01Part1.run("./lib/day_01/input.txt")
Day01Part1.run("./lib/day_01/test1.txt")
Day01Part1.run("./lib/day_01/test2.txt")
