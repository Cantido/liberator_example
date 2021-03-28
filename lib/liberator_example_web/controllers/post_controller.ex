defmodule LiberatorExampleWeb.PostController do
  use Liberator.Resource

  alias LiberatorExample.Blog
  alias LiberatorExample.Blog.Post

  require Logger

  @impl true
  def allowed_methods(_), do: ["GET", "POST", "PUT", "DELETE"]

  @impl true
  def available_media_types(_), do: ["application/json"]

  @impl true
  def processable?(conn) do
    valid_param?(conn.params["post"], "title") and valid_param?(conn.params["post"], "content")
  end

  defp valid_param?(params, key) do
    if not is_nil(params) and Map.has_key?(params, key) do
      not is_nil(params[key])
    else
      true
    end
  end

  @impl true
  def exists?(conn) do
    id = conn.params["id"]

    if is_nil(id) do
      # Showing the index
      posts = Blog.list_posts()
      %{content: posts}
    else
      # Interacting with an individual post.
      case Blog.get_post(id) do
        nil -> false
        post -> %{content: post, new: false}
      end
    end
  end

  @impl true
  def delete!(conn) do
    {:ok, _post} = Blog.delete_post(conn.assigns[:content])
    true
  end

  @impl true
  def put!(conn) do
    # We already fetched this resource when we checked for it in `exists?/1`,
    # so we can just grab what we cached
    post = conn.assigns[:content]

    {:ok, updated_post} = Blog.update_post(post, conn.params["post"])

    # Update the content we're working with, because we will want to return it in a handler
    %{content: updated_post}
  end

  @impl true
  def post!(conn) do
    {:ok, post} = Blog.create_post(conn.params["post"])

    # Update the content we're working with, because we will want to return it in a handler
    %{
      content: post,
      location: LiberatorExampleWeb.Router.Helpers.post_url(conn, :show, post.id)
    }
  end

  @impl true
  def new?(conn) do
    Map.get(conn.assigns, :new, true)
  end

  @impl true
  def handle_ok(conn) do
    %{data: conn.assigns[:content]}
  end

  @impl true
  def handle_created(conn) do
    %{data: conn.assigns[:content]}
  end

  @impl true
  def handle_not_found(_conn) do
    %{errors: "Not found"}
  end

  @impl true
  def handle_unprocessable_entity(conn) do
    %{errors: "Unprocessable entity"}
  end

  @impl true
  def respond_with_entity?(conn) do
    conn.method != "DELETE"
  end

  @impl true
  def handle_error(conn, error, failed_step) do
    Logger.error("conn failed at step #{failed_step} with error #{inspect error}")
    Plug.Conn.send_resp(conn, 500, "Internal server error")
  end
end
