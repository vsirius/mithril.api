defmodule Mithril.Authorization.AppTest do
  @moduledoc false

  use Mithril.DataCase, async: true

  alias Mithril.Authorization.App
  alias Mithril.UserRoleAPI
  alias Mithril.Fixtures
  alias Mithril.TokenAPI.Token

  test "expire old tokens" do
    client_type = Fixtures.create_client_type(%{scope: "app:authorize"})
    client = Fixtures.create_client(%{client_type_id: client_type.id})
    user = Fixtures.create_user()
    role = Fixtures.create_role(%{scope: "app:authorize"})
    UserRoleAPI.create_user_role(%{
      "user_id" => user.id,
      "client_id" => client.id,
      "role_id" =>  role.id
    })

    App.grant(%{
      "user_id" => user.id,
      "client_id" => client.id,
      "redirect_uri" => client.redirect_uri,
      "scope" => "app:authorize"
    })

    now = :os.system_time(:seconds)

    assert 1 == Token
      |> Repo.all
      |> Enum.filter(&(Map.get(&1, :expires_at) > now))
      |> Enum.count
    assert 1 == Token |> Repo.all |> Enum.count

    App.grant(%{
      "user_id" => user.id,
      "client_id" => client.id,
      "redirect_uri" => client.redirect_uri,
      "scope" => "app:authorize"
    })

    assert 1 == Token
      |> Repo.all
      |> Enum.filter(&(Map.get(&1, :expires_at) > now))
      |> Enum.count
    assert 2 == Token |> Repo.all |> Enum.count
  end
end
