defmodule Day02 do
  def run_part1(file_path) do 
    file_path
    |> process_input()
    #|> IO.inspect(charlists: :as_lists)
    |> determine_all_reports_safety()
    |> Enum.count(fn x -> x == true end)
    |> IO.inspect()
  end

  def process_input(file_path) do
    case File.read(file_path) do
      {:ok, content} -> 
        process_lines(content)
      {:error, msg} ->
        IO.puts(msg)
        []
    end
  end

  def process_lines(content) do
    String.split(content, "\n", trim: true)
    |> Enum.map(fn line -> process_line(line) end)
  end

  def process_line(line) do
    String.split(line, " ", trim: true)
    |> Enum.map(fn ch -> String.to_integer(ch) end)
  end

  def determine_all_reports_safety(reports) do
    Enum.map(reports, fn report -> determine_report_safety(report) end)
  end

  def determine_report_safety(report) do
    safe?(report, :start)
  end

  def safe?([], _current), do: true
  def safe?([_], _current), do: true
  def safe?([first, second | rest], current) do
    diff = first - second

    direction = determine_direction(diff) 

    cond do 
      direction == :none -> 
        false
      current != :start and direction != current -> 
        false
      abs(diff) > 3 -> 
        false
      true ->
        safe?([second | rest], direction)  
    end
  end

  def determine_direction(diff) do
    cond do
      diff < 0 -> 
        :desc
      diff == 0 -> 
        :none
      diff > 0 ->
        :asc
    end
  end

end

Day02.run_part1("./lib/day_02/input.txt")
