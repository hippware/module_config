# ModuleConfig

A simple set of macros to help with module-specific configuration.

A common idiom in Elixir is to group configuration based on the module or
subsystem where it is used. This looks something like the following:

```elixir
config :my_app, MyModule,
  value1: :foo,
  value2: :bar
```

Retrieving those values with `Application.get_env/3` can be cumbersome, since
what you get back is not a single value, but a keyword list. `ModuleConfig`
is a set of macros that make working with those values a bit easier.

To use it, `use ModuleConfig` in your module and pass the name of your app:

```elixir
defmodule MyApp.MyModule do
  use ModuleConfig, otp_app: :my_app

  # ...
end
```

Now you can call `config/1` to retrive the full configuration for that module
as a map. You can optionally pass a keyword list of overrides that will be
merged into the stored configuration.

```elixir
config = config()
config.value1

# OR

config = config(other_value: :foo)
config.other_value
```

If you only want a single value, you can call `get_config/2`, which will
return a single value.

```elixir
value = get_config(:value1)

# OR

value = get_config(:value1, :default)
```

## Installation

The package can be installed by adding `module_config` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:module_config, "~> 1.0.0"}
  ]
end
```

The docs can be found at
[https://hexdocs.pm/module_config](https://hexdocs.pm/module_config).
