return {
  name = "mdk build log",
  builder = function()
    local files = vim.fn.glob(LazyVim.root() .. "/**/*.log", false, true)
    local log_pwd = (#files > 0) and files[1] or nil
    if not log_pwd then
      return {
        cmd = "echo",
        args = { "No .log file found" },
        cwd = LazyVim.root(),
      }
    end
    return {
      cmd = "sed",
      args = {
        "-i",
        "'s|^..[\\\\/]||'",
        log_pwd,
        "&&",
        "cat",
        log_pwd,
      },
      cwd = LazyVim.root(),
      components = {
        { "on_complete_notify", statuses = {} },
        { "on_output_quickfix", open_on_match = true },
        { "on_complete_dispose", timeout = 1 },
        "default",
      },
      default_component_params = {
        errorformat = "" .. [[%-GBuild Time Elapsed:%.%#,]] .. [[%f(%l):%m,]] .. [[%f(%l): %t%*[^:]: %m,]],
      },
    }
  end,
  desc = "Build firmware and print compilation messages in real time",
  params = {},
  priority = 51,
}
