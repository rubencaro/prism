defmodule Prism.Requester do
  @moduledoc """
  Here the magic gets done
  """

  def spread(%Plug.Conn{} = conn) do
    url = "http://localhost:4001/count"
    # Timeout is 1 msec, no need to spawn processes and the wait for them
    HTTPoison.get(url, [], recv_timeout: 1)
    HTTPoison.get(url, [], recv_timeout: 1)
    HTTPoison.get(url, [], recv_timeout: 1)

    # Let one of them fail completely, showing that it will
    # not affect the client or the other requests.
    HTTPoison.get(url <> "badurl", [], recv_timeout: 1)

    HTTPoison.get(url, [], recv_timeout: 1)
    HTTPoison.get(url, [], recv_timeout: 1)
    conn
  end
end