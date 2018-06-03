defmodule Prism.Counter do
  use Agent

  def start_link(_), do: Agent.start_link(fn -> 0 end, name: __MODULE__)
end
