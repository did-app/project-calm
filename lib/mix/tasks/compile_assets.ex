defmodule Mix.Tasks.CompileAssets do
  use Mix.Task
  require Logger

  def run(_args) do
    {_, 0} = System.cmd("npm", ["run", "compile:css"], cd: "lib/calm/www")

    Logger.info("Assets compiled successfully")
  end
end
