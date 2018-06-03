defmodule Prism.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/hello" do
    send_resp(conn, 200, "world")
  end

  get "/request" do
    conn
    |> Prism.Requester.spread
    |> send_resp(200, "spread")
  end

  get "/count" do
    IO.inspect("counting")

    # Let this be slow, clearly showing if this gets
    # interrupted by the timeout on the client.
    Process.sleep(2000)

    :ok = Agent.update(Prism.Counter, &(&1 + 1))
    IO.inspect("counted")
    send_resp(conn, 200, "counted")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end