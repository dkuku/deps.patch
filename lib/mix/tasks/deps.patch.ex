defmodule Mix.Tasks.Deps.Patch do
  @moduledoc File.read!("README.md")

  use Mix.Task
  @patch_path "./patch/"
  @deps_path "deps/"

  @doc """
  entry point for escript
  """
  def main(_args \\ []) do
    print_to_console("running mix deps.patch")
    patch()
  end

  @impl true
  @doc """
  entry point for mix task
  """
  def run(args \\ []) do
    Mix.Task.run("deps.get", args)
    patch()
  end

  defp patch do
    @patch_path
    |> Kernel.<>("**")
    |> Path.wildcard()
    |> Enum.map(&Path.basename/1)
    |> Enum.map(&find_dep/1)
    |> Enum.reject(&is_nil(&1))
    |> Enum.map(&run_patch/1)
    |> Enum.reject(fn {_dep, _patch, success?} -> success? end)
    |> case do
      [] -> "everything patched"
      failed_list -> "some patches failed: #{Enum.map_join(failed_list, ",\n", & "#{inspect(&1)}")}"
    end
    |> print_to_console()
  end

  defp run_patch({dep, patch}) do
    {result, exit_code} =
      System.cmd("patch", ["-d", @deps_path <> dep, "-p1", "-i", "../." <> @patch_path <> patch])

    print_to_console(result)
    success? = exit_code == 0
    {dep, patch, success?}
  end

  defp find_dep(patch) do
    get_deps()
    |> Enum.find(&String.starts_with?(patch, &1))
    |> case do
      nil -> nil
      dep -> {dep, patch}
    end
  end

  defp get_deps do
    {deps, _bindings} = Code.eval_file("mix.lock")

    deps
    |> Map.keys()
    |> Enum.map(&to_string(&1))
  end

  defp print_to_console(result) do
    if Code.ensure_loaded?(Mix) do
      Mix.shell().info(result)
    else
      IO.puts(result)
    end
  end
end
