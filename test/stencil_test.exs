defmodule StencilTest do
  use ExUnit.Case
  doctest Stencil

  test "greets the world" do
    assert Stencil.hello() == :world
  end
end
