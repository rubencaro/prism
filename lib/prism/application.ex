defmodule Prism.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Plug.Adapters.Cowboy, scheme: :http, plug: Prism.Router, options: [port: 4001]},
    ]

    opts = [strategy: :one_for_one, name: Prism.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
