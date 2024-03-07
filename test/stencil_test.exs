defmodule StencilTest do
  use ExUnit.Case
  doctest Stencil

  require EEx

  test "all fragments" do
   ast =
     EEx.compile_string("""
      <%| before_block do %>
        before
      <% end %>
      <%| inner_block do %>
        inner
      <% end %>
      <%| after_block do %>
        after
      <% end %>
      """, engine: Stencil.Engine)
    IO.puts(Macro.to_string(ast))

    {result, _bindings} = Code.eval_quoted(ast, assigns: [], fragment: :inner_block)

    assert result =~ "inner"
    refute result =~ "before"
    refute result =~ "after"
  end

  test "fragment inside text" do
   ast =
     EEx.compile_string("""
      before
      <%| inner_block do %>
        inner
      <% end %>
      after
      """, engine: Stencil.Engine)

    IO.puts(Macro.to_string(ast))

    {result, _bindings} = Code.eval_quoted(ast, assigns: [], fragment: :inner_block)

    assert result =~ "inner"
    refute result =~ "before"
    refute result =~ "after"
  end
end
