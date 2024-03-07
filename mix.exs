defmodule Xrpl.MixProject do
  use Mix.Project

  def project do
    [
      app: :xrpl,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      description: "XRPL HTTP client for Elixir",
      package: package(),
      aliases: aliases(),
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
      # Core
      {:tesla, "~> 1.7"},
      {:hackney, "~> 1.17"},
      {:jason, ">= 1.0.0"},

      # Validation
      {:goal, "~> 0.2"},

      # Dev
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:credo, "~> 1.7.5", only: [:dev, :test], runtime: false},
      {:sobelow, "~> 0.12", only: [:dev, :test], runtime: false},
      {:styler, "~> 0.11", only: [:dev, :test], runtime: false}
    ]
  end

  defp aliases, do: [quality: ["format --check-formatted", "sobelow --config", "credo --strict"]]

  defp package do
    [
      name: "xrpl",
      files: ~w(lib mix.exs README.md LICENSE),
      licenses: ["AGPL-3.0-or-later"],
      maintainers: ["Julien Lucca"],
      links: %{"Github" => "https://github.com/lucca65/xrpl"}
    ]
  end
end
