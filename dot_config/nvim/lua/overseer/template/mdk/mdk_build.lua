return {
  -- Required fields
  name = "mdk build",
  builder = function(params)
    local files = vim.fn.glob(LazyVim.root() .. "/**/*.uvprojx", false, true)
    local uvprojx = files[1]
    local log_name = vim.fn.fnamemodify(uvprojx, ":t:r") .. ".log"
    return {
      cmd = { "UV4" },
      args = { "-b", "-j8", uvprojx, "-o", log_name },
      cwd = LazyVim.root(),
      name = "mdk build",
      components = {
        { "run_after", task_names = { "mdk build log" }, detach = true, statuses = { "SUCCESS", "FAILURE" } },
        { "on_complete_dispose", timeout = 1 },
        "default",
      },
      default_component_params = {
        errorformat = "" .. [[%f:%l:%m,]] .. [[%-G[Process exited%.%#,]],
      },
    }
  end,
  desc = "Compile the firmware using MDK (no flashing)",
  params = {},
  priority = 2,
}
