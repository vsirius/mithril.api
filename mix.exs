defmodule Mithril.Mixfile do
  use Mix.Project

  @version "0.1.106"

  def project do
    [app: :mithril_api,
     description: "Add description to your package.",
     package: package(),
     version: @version,
     elixir: "~> 1.4",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps(),
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: [coveralls: :test],
     docs: [source_ref: "v#\{@version\}", main: "readme", extras: ["README.md"]]]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [extra_applications: [:logger, :logger_json, :confex, :runtime_tools,
                          :ecto, :postgrex,
                          :cowboy, :httpoison, :poison,
                          :phoenix, :phoenix_ecto, :eview],
     mod: {Mithril, []}]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # To depend on another app inside the umbrella:
  #
  #   {:myapp, in_umbrella: true}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:distillery, "~> 1.2"},
     {:confex, "~> 3.2"},
     {:ecto, "~> 2.1"},
     {:postgrex, "~> 0.13.2"},
     {:cowboy, "~> 1.1"},
     {:httpoison, "~> 0.12.0"},
     {:poison, "~> 3.1"},
     {:phoenix, "~> 1.3.0-rc"},
     {:logger_json, "~> 0.5.0"},
     {:eview, "~> 0.11"},
     {:phoenix_ecto, "~> 3.2"},
     {:ecto_paging, ">= 0.0.0"},
     {:comeonin, ">= 0.0.0"},
     {:secure_random, ">= 0.0.0"},
     {:benchfella, ">= 0.3.4", only: [:dev, :test]},
     {:ex_doc, ">= 0.15.0", only: [:dev, :test]},
     {:excoveralls, ">= 0.5.0", only: [:dev, :test]},
     {:dogma, ">= 0.1.12", only: [:dev, :test]},
     {:credo, ">= 0.5.1", only: [:dev, :test]}]
  end

  # Settings for publishing in Hex package manager:
  defp package do
    [contributors: ["Nebo #15"],
     maintainers: ["Nebo #15"],
     licenses: ["LISENSE.md"],
     links: %{github: "https://github.com/Nebo15/trump.api"},
     files: ~w(lib LICENSE.md mix.exs README.md)]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test":       ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
