local function is_in_git_repo()
  local output = vim.fn.systemlist({ "git", "rev-parse", "--is-inside-work-tree" })
  return output[1] == "true"
end
if vim.fn.has("win32") == 1 then
  if is_in_git_repo() then
    local files = vim.fn.glob(LazyVim.root() .. "/**/*.uvprojx", false, true)
    if #files > 0 then
      require("overseer").register_template(require("overseer.template.mdk.mdk_build"))
      require("overseer").register_template(require("overseer.template.mdk.mdk_rebuild"))
      require("overseer").register_template(require("overseer.template.mdk.mdk_flash"))
      require("overseer").register_template(require("overseer.template.mdk.mdk_build_flash"))
      require("overseer").register_template(require("overseer.template.mdk.mdk_build_log"))
      require("overseer").register_template(require("overseer.template.mdk.mdk_generate_compile_commands"))
    end
  end
end
