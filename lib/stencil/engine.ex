defmodule Stencil.Engine do
  @behaviour EEx.Engine

  require Stencil

  @impl true
  def init(opts) do
    EEx.SmartEngine.init(opts)
    |> EEx.SmartEngine.handle_expr("", quote(do: inside_fragment = nil))
  end

  @impl true
  defdelegate handle_body(state), to: EEx.Engine

  @impl true
  defdelegate handle_begin(state), to: EEx.SmartEngine

  @impl true
  defdelegate handle_end(state), to: EEx.SmartEngine

  @impl true
  def handle_text(state, _meta, text) do
    ast =
      quote do
        if var!(fragment) == inside_fragment do
          unquote(text)
        end
      end

    EEx.SmartEngine.handle_expr(state, "=", ast)
  end

  @impl true
  def handle_expr(state, "|", {fragment_name, _meta, [[do: args]]}) do
    ast =
      quote do
        if var!(fragment) == unquote(fragment_name) do
          inside_fragment = unquote(fragment_name)
          unquote(args)
        end
      end

    EEx.SmartEngine.handle_expr(state, "=", ast)
  end

  @impl true
  def handle_expr(state, marker, expr) do
    EEx.SmartEngine.handle_expr(state, marker, expr)
  end
end
