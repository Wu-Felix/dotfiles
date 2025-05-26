return {
  name = "generate compile_commands.json",
  builder = function()
    return {
      cmd = { "compiledb" },
      args = { "-n", "make" },
      cwd = LazyVim.root(),
    }
  end,
  desc = "generate compile_commands.json",
  params = {},
  priority = 50,
}
