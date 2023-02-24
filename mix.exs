defmodule Xrpl.MixProject do
  use Mix.Project

  def project do
    [
      app: :xrpl,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      description: "XRPL client for Elixir",
      package: package(),
      deps: deps(),
      docs: [
        main: "readme",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tesla, "~> 1.4"},
      {:hackney, "~> 1.17"},
      {:jason, ">= 1.0.0"},

      # Dev
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false}
    ]
  end

  defp package() do
    [
      name: "xrpl",
      files: ~w(lib mix.exs README.md LICENSE),
      licenses: ["AGPL-3.0-or-later"],
      maintainers: ["Julien Lucca"]
    ]
  end
end
