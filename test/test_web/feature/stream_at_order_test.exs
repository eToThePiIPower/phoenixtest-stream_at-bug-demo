defmodule StreamAtOrderTest do
  use TestWeb.FeatureCase

  test "stream(_, at: 0) works", %{conn: conn} do
    conn
    |> visit("/test")
    |> open_browser()
    |> click_button("Load more")
    |> open_browser()
    |> assert_has("#list-1+#list-2+#list-3+#list-4+#list-5+#list-6+#list-7+#list-8")
  end
end

#
