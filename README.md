# MixDepsPatch

Script for patching dependencies before compilation.
This is an alternative for creating github forks and can be used without git installed.
The only dependency is the `patch` command.

## Usage

create a folder named patch in your app directory

```sh
mkdir patch
```

Make a copy of the file you wan't to patch in the deps folder.

```sh
cd deps/dependency_name
git diff > ../../patch/dependency_name.patch
cd ../../
```

and then use it instead of deps.get
(mix deps.get is run from this task)
```
mix deps.patch
```

## Installation

You can either install it globally

```sh
mix archive.build
mix archive.install mix_deps_patch-0.0.0.ez
```

or by adding `mix_deps_patch` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:mix_deps_patch, "~> 0.0.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/mix_deps_patch>.

