defmodule Stencil do
  @moduledoc """
  Documentation for `Stencil`.
  """

  def fragment({fragment_name, _meta, [args]}) do
    quote do
      if(var!(fragment) == unquote(fragment_name), unquote(args))
    end
  end
end
