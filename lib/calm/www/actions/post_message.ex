defmodule Calm.WWW.Actions.PostMessage do
  # use Raxx.SimpleServer

  # def handle_request(request, _config) do
  #   ["t", thread_id, "post"] = request.path
  #   {:ok, session} = load_session()
  #   {:ok, invite} = session[thread_id]
  #   Invite.post(message)
  #   # fetch invite for private, get invite for public
  #   IO.inspect(request)
  #   IO.inspect(get_form(request))
  #   {:ok, thread} = Calm.Thread.load()
  #   {:ok, _} = Calm.Thread.check_password(thread(session))
  #   {:ok, message} = Calm.Thread.post_message(thread, form_data)
  #
  #   redirect(thread_path(thread_id, message_id))
  # end
  #
  # def get_form(request) do
  #   URI.decode_query(request.body || "")
  # end
end
