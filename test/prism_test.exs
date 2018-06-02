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
end
