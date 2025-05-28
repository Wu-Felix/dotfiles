return {
  -- Required fields
  name = "mpv music",
  builder = function(params)
    return {
      cmd = { "mpv" },
      args = { "--no-video", "--shuffle", "./*" },
      cwd = os.getenv("HOME") .. "/OneDrive/PARA/resource/music",
      name = "mpv music ",
      components = {
        { "on_output_summarize", max_lines = 2 },
        "default",
      },
    }
  end,
  desc = "mpv music",
  params = {},
  priority = 50,
}
