defmodule Onebrc do
  def read_csv_file(file_path) do
    File.stream!(file_path)
    |> Stream.drop(2)
    |> Stream.map(&process_line/1)
    |> Enum.to_list()
  end

  def result do
    r = read_csv_file("./weather_stations.csv")

    town_stats =
    r
    |> Enum.group_by(&elem(&1, 0))
    |> Enum.map(fn {town, values} ->
      min = Enum.min(Enum.map(values, &elem(&1, 1)))
      mean = Enum.sum(Enum.map(values, &elem(&1, 1))) / length(values)
      max = Enum.max(Enum.map(values, &elem(&1, 1)))

      {town, %{min: min, mean: mean, max: max}}
    end)

    IO.inspect(town_stats, label: "town_stats")
  end

  defp process_line(line) do
    fields =
      line
      |> String.split(";")
      |> Enum.map(&String.trim/1)

    town = Enum.at(fields, 0)
    value = String.to_float(Enum.at(fields, 1))

    {town, value}
  end
end
