defmodule Prism.MixProject do
  use Mix.Project

  def project do
    [
      app: :prism,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Prism.Application, []}
    ]
  end

  defp deps do
    [
      {:cowboy, "~> 1.1"},
      {:plug, "~> 1.5"},
      {:httpoison, "~> 1.1"}
    ]
  end
end
