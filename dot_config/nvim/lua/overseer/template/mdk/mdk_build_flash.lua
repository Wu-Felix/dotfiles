return {
  -- Required fields
  name = "mdk build and flash",
  builder = function(params)
    local files = vim.fn.glob(LazyVim.root() .. "/**/*.uvprojx", false, true)
    local uvprojx = files[1]
    local log_name = vim.fn.fnamemodify(uvprojx, ":t:r") .. ".log"
    return {
      cmd = { "UV4" },
      args = { "-b", "-j8", uvprojx, "-o", log_name },
      cwd = LazyVim.root(),
      name = "mdk build downlocal",
      components = {
        {
          "run_after",
          task_names = { "mdk build log", "mdk flash" },
          detach = true,
          statuses = { "SUCCESS", "FAILURE" },
        },
        { "on_complete_dispose", timeout = 1 },
        "default",
      },
    }
  end,
  desc = "Compile the project with MDK and flash the firmware to the target device",
  params = {},
  priority = 0,
}
