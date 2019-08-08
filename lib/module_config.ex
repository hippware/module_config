defmodule ModuleConfig do
  @moduledoc """
  Simplifies module-based configuration.
  """

  @doc false
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @module_config_otp_app opts[:otp_app]

      unless @module_config_otp_app do
        raise ArgumentError, "missing :otp_app option on use ModuleConfig"
      end

      @behaviour ModuleConfig

      @impl true
      def config(opts \\ []) do
        @module_config_otp_app
        |> Confex.get_env(__MODULE__, [])
        |> Keyword.merge(opts)
        |> Enum.into(%{})
      end

      @impl true
      def get_config(key, default \\ nil) do
        Map.get(config(), key, default)
      end

      @impl true
      def put_config(key, value) do
        config =
          @module_config_otp_app
          |> Application.get_env(__MODULE__, [])
          |> Keyword.put(key, value)

        Application.put_env(@module_config_otp_app, __MODULE__, config)
      end
    end
  end

  ## User callbacks

  @doc """
  Returns module configuration.
  """
  @callback config(Keyword.t()) :: map()

  @doc """
  Returns a specific module configuration value.
  """
  @callback get_config(atom()) :: any()

  @doc """
  Sets a specific module configuration value.
  """
  @callback put_config(atom(), any()) :: :ok
end
