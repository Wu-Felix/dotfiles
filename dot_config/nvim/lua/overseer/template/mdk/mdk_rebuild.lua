return {
  -- Required fields
  name = "mdk rebuild",
  builder = function(params)
    local files = vim.fn.glob(LazyVim.root() .. "/**/*.uvprojx", false, true)
    local uvprojx = files[1]
    local log_name = vim.fn.fnamemodify(uvprojx, ":t:r") .. ".log"
    return {
      cmd = { "UV4" },
      args = { "-r", "-j0", uvprojx, "-o", log_name },
      cwd = LazyVim.root(),
      name = "mdk rebuild",
      components = {
        { "run_after", task_names = { "mdk build log" }, detach = true, statuses = { "SUCCESS", "FAILURE" } },
        { "on_complete_dispose", timeout = 1 },
        "default",
      },
    }
  end,
  desc = "Perform a full rebuild: clean all previous outputs and build the firmware afresh",
  params = {},
  priority = 2,
}
