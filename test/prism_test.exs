defmodule PrismTest do
  use ExUnit.Case, async: false
  use Plug.Test

  @moduledoc """
  To test the actual requester you can go interactive `iex -S mix` and then:

    iex(1)> url = "http://localhost:4001/request"
    "http://localhost:4001/request"
    iex(2)> Agent.get(Prism.Counter, & &1)
    0
    iex(3)> HTTPoison.get(url)
    "counting"
    "counting"
    "counting"
    "counting"
    "counting"
    {:ok,
    %HTTPoison.Response{
      body: "spread",
      headers: [
        {"server", "Cowboy"},
        {"date", "Sun, 03 Jun 2018 07:18:20 GMT"},
        {"content-length", "6"},
        {"cache-control", "max-age=0, private, must-revalidate"}
      ],
      request_url: "http://localhost:4001/request",
      status_code: 200
    }}
    iex(4)> "counted"
    "counted"
    "counted"
    "counted"
    "counted"

    nil
    iex(5)> Agent.get(Prism.Counter, & &1)
    5

  """

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
end
