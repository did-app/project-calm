defmodule Calm.WWW.Actions.ThreadPage do
  use Raxx.SimpleServer
  use Calm.WWW.Layout, arguments: [:thread_id, :updates, :csrf_token]

  def handle_request(request, _config) do
    ["t", thread_id] = request.path

    updates = [
      %{
        text:
          ~s"""
          Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

          https://did.app/docs
          A much smaller random paragraph
          """
          |> String.trim(),
        name: "Peter",
        color: "teal",
        time: "Yesterday"
      },
      %{
        text:
          ~s"""
          Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
          """
          |> String.trim(),
        name: "Susan Furtado",
        color: "gray",
        time: "2 hours ago"
      },
      %{
        text:
          ~s"""
          Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

          - one
          - two

          1. one
          2. two

          A much smaller random paragraph
          """
          |> String.trim(),
        name: "Peter",
        color: "teal",
        time: "5 minutes ago"
      }
    ]

    response(:ok)
    |> render(thread_id, updates, "dummy")

    # TODO post anywhere
    # Create a link
  end
end
