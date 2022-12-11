defmodule MixDepsPatch.MixProject do
  use Mix.Project

  def project do
    [
      app: :mix_deps_patch,
      version: "0.0.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      escript: escript(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    []
  end

  defp escript do
    [main_module: Mix.Tasks.Deps.Patch]
  end
end
