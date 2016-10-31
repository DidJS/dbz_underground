defmodule ElmDbz.PageController do
  use ElmDbz.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
