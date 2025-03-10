defmodule TestWeb.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use TestWeb, :verified_routes

      import TestWeb.FeatureCase

      import PhoenixTest
    end
  end

  setup _tags do
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
