defmodule Stencil.Engine do
  @behaviour EEx.Engine

  require Stencil

  @impl true
  defdelegate init(opts), to: EEx.Engine

  @impl true
  defdelegate handle_body(state), to: EEx.Engine

  @impl true
  defdelegate handle_begin(state), to: EEx.SmartEngine

  @impl true
  defdelegate handle_end(state), to: EEx.SmartEngine

  @impl true
  defdelegate handle_text(state, meta, text), to: EEx.SmartEngine

  @impl true
  def handle_expr(state, "|", expr) do
    EEx.SmartEngine.handle_expr(state, "=", Stencil.fragment(expr))
  end

  @impl true
  def handle_expr(state, marker, expr) do
    EEx.SmartEngine.handle_expr(state, marker, expr)
  end
end
