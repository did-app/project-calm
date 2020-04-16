defmodule Calm.WWW.Actions.HomePageTest do
  use ExUnit.Case

  alias Calm.WWW.Actions.HomePage

  test "returns the Raxx.Kit home page" do
    request = Raxx.request(:GET, "/")

    response = HomePage.handle_request(request, Calm.WWW.init())

    assert response.status == 200
    assert {"content-type", "text/html"} in response.headers
    assert String.contains?(IO.iodata_to_binary(response.body), "Raxx.Kit")
  end
end
