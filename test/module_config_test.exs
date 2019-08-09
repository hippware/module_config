defmodule ModuleConfigTest do
  use ExUnit.Case, async: false

  use ModuleConfig, otp_app: :module_config

  describe "config/1" do
    test "retrieves the entire config" do
      assert config() == %{value_1: :a, value_2: :b}
    end

    test "overrides a single value" do
      assert config(value_1: :c) == %{value_1: :c, value_2: :b}
    end

    test "adds a value that did not exist" do
      assert config(value_3: :c) == %{value_1: :a, value_2: :b, value_3: :c}
    end
  end

  describe "get_config/2" do
    test "retrieves a single value" do
      assert get_config(:value_1) == :a
    end

    test "returns nil when the key doesn't exist" do
      refute get_config(:value_3)
    end

    test "returns default when the value doesn't exist" do
      assert get_config(:value_3, :c) == :c
    end

    test "doesn't override an existing value" do
      assert get_config(:value_1, :c) == :a
    end
  end

  describe "put_config/2" do
    setup do
      config = Enum.into(config(), [])

      on_exit fn ->
        Application.put_env(:module_config, __MODULE__, config)
      end
    end

    test "stores a new value" do
      put_config(:value_3, :c)

      assert get_config(:value_3) == :c
    end

    test "overwrites an existing value" do
      put_config(:value_1, :c)

      assert get_config(:value_1) == :c
    end
  end
end
