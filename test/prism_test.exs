defmodule PrismTest do
  use ExUnit.Case, async: false
  use Plug.Test

  @opts Prism.Router.init([])

  test "greets the world" do
    assert Prism.hello() == :world
  end

  test "returns hello world" do
    # Create a test connection
    conn = conn(:get, "/hello")

    # Invoke the plug
    conn = Prism.Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "world"
  end

  test "makes calls and they are received" do
    :ok = Agent.update(Prism.Counter, fn _ -> 0 end)

    tasks =
      Enum.reduce(0..9, [], fn _, acc ->
        t =
          Task.async(fn ->
            conn = conn(:get, "/request")
            conn = Prism.Router.call(conn, @opts)
            assert conn.status == 200
            :ok
          end)

        [t | acc]
      end)

    for t <- tasks, do: :ok = Task.await(t)

    wait_for(fn ->
      count = Agent.get(Prism.Counter, & &1)
      IO.inspect(count)
      count == 50
    end)
  end

  @doc """
    Wait for given function to return true.
    Optional `msecs` and `step`.
  """
  def wait_for(func, msecs \\ 5_000, step \\ 100) do
    if func.() do
      :ok
    else
      if msecs <= 0, do: raise("Timeout!")
      :timer.sleep(step)
      wait_for(func, msecs - step, step)
    end
  end
end
