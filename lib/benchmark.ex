defmodule Benchmark do
  def measure_time(fun) do
    {time, _result} = :timer.tc(fun)
    time
  end

  def run_benchmark do
    result_time = measure_time(&Onebrc.result/0) / 1_000_000

    IO.puts("Result Time: #{result_time} microseconds")
  end
end
