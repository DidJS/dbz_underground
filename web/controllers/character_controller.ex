defmodule ElmDbz.CharacterController do
  use ElmDbz.Web, :controller

  alias Bolt.Sips, as: Bolt

  def index(conn, _params) do
    cypher = """
      MATCH (p:Person) RETURN p as character
    """

    data = Bolt.query!(Bolt.conn, cypher)
    render(conn, "index.json", characters: data)
  end

end
