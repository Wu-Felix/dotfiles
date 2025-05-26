return {
  -- Required fields
  name = "mdk flash",
  builder = function(params)
    local files = vim.fn.glob(LazyVim.root() .. "/**/*.uvprojx", false, true)
    local uvprojx = files[1]
    local log_name = vim.fn.fnamemodify(uvprojx, ":t:r") .. ".log"
    return {
      cmd = { "UV4" },
      args = { "-f", "-j0", uvprojx, "-o", log_name },
      cwd = LazyVim.root(),
      name = "mdk flash",
      components = {
        { "unique" },
        "default",
      },
    }
  end,
  desc = "Compile the project with MDK and flash the firmware to the target device",
  params = {},
  priority = 1,
}
