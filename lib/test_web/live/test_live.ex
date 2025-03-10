defmodule TestWeb.TestLive do
  use TestWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <.button :if={!@hide_load_button} class="w-full text-[0.75rem] py-1" phx-click="load-more">
      Load more
    </.button>
    <ul id="list-test" phx-update="stream">
      <li :for={{dom_id, item} <- @streams.list} id={dom_id}>{item.body}</li>
    </ul>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    list1 = [%{id: 8, body: 8}, %{id: 7, body: 7}, %{id: 6, body: 6}, %{id: 5, body: 5}]
    # list2 = [%{id: 4, body: 4}, %{id: 3, body: 3}, %{id: 2, body: 2}, %{id: 1, body: 1}]

    socket
    |> assign(:hide_load_button, false)
    |> stream(:list, [], reset: true)
    # Should insert in reverse, above the empty starter list
    # PhoenixTest never reverses this, despite the documented behavior of at: 0
    |> stream(:list, list1, at: 0)
    # Shoud inserted in reverse, above the previous list
    # With the load button removed, PhoenixTest loads both lists together in
    # unrevesedd order with list0 below list1, ignoring at: 0 completely
    # |> stream(:list, list2, at: 0)
    |> ok
  end

  @impl true
  def handle_event(_params, _evnet, socket) do
    list2 = [%{id: 4, body: 4}, %{id: 3, body: 3}, %{id: 2, body: 2}, %{id: 1, body: 1}]

    socket
    # Inserted in reverse, above the previous list
    # PhoenixTest Loads this one correctly, but the initial list is still
    # unreversed
    |> stream(:list, list2, at: 0)
    |> assign(:hide_load_button, true)
    |> noreply
  end

  defp ok(socket), do: {:ok, socket}

  defp noreply(socket), do: {:noreply, socket}
end
