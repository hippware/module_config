defmodule ModuleConfig.MixProject do
  use Mix.Project

  @version "1.0.0"

  def project do
    [
      app: :module_config,
      version: @version,
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      docs: docs(),
      deps: deps(),
      source_url: "https://github.com/hippware/module_config",
      dialyzer: [
        flags: [
          :error_handling,
          :race_conditions,
          :underspecs,
          :unmatched_returns
        ]
        # ignore_warnings: "dialyzer_ignore.exs",
        # list_unused_filters: true
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
      {:confex, "~> 3.4"},
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.6", only: :dev, runtime: false},
      {:ex_check, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: [:dev, :test]}
    ]
  end

  defp description do
    """
    DawdleDB uses Dawdle and SQS to capture change notifications from
    PostgreSQL.
    """
  end

  defp package do
    [
      maintainers: ["Phil Toland"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/hippware/dawdle_db"}
    ]
  end

  defp docs do
    [
      source_ref: "v#{@version}",
      main: "readme",
      extras: ["README.md"]
    ]
  end
end
