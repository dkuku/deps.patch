defmodule MixDepsPatch.MixProject do
  use Mix.Project

  def project do
    [
      app: :mix_deps_patch,
      version: "0.0.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      escript: escript(),
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  def description do
    """
    Task for patching dependencies after downloading from hex, before compilation.
    This is an alternative for creating github forks and can be used without git installed.
    The only dependency is the `patch` command.
    """
  end

  def package do
    %{
      licenses: ["BSD-2-Clause"],
      links: %{"GitHub" => "https://github.com/dkuku/deps.patch"}
    }
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
