defmodule Prism.Requester do
  @moduledoc """
  Here the magic gets done
  """

  def spread(%Plug.Conn{} = conn) do
    url = "http://" <> conn.host <> "/count"
    # timeout is 1 msec, no need to spawn processes and the wait for them
    HTTPoison.get(url, [], recv_timeout: 1)
    HTTPoison.get(url, [], recv_timeout: 1)
    HTTPoison.get(url, [], recv_timeout: 1)
    HTTPoison.get(url, [], recv_timeout: 1)
    HTTPoison.get(url, [], recv_timeout: 1)
    conn
  end
end