defmodule ModuleConfigTest do
  use ExUnit.Case
  doctest ModuleConfig

  test "greets the world" do
    assert ModuleConfig.hello() == :world
  end
end
