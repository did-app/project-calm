defmodule Calm.WWW.Router do
  use Raxx.Router
  alias Calm.WWW.Actions

  section([{Raxx.Logger, Raxx.Logger.setup(level: :info)}], [
    {%{path: []}, Actions.HomePage},
    {%{path: ["t", _thread_id]}, Actions.ThreadPage},
    {%{path: ["t", _thread_id, "post"]}, Actions.PostMessage},
    {%{path: ["i", _id, _secret]}, Actions.OpenInvite}
  ])

  section([{Raxx.Logger, Raxx.Logger.setup(level: :debug)}], [
    {_, Actions.NotFoundPage}
  ])
end
