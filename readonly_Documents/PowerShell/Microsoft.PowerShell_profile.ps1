# 引入 ps-read-line
Import-Module PSReadLine
# 引入 PSFzf
Import-Module PSFzf

Set-alias 'sudo' 'gsudo'

# 引入 posh-git
Import-Module posh-git
# 设置预测文本来源为历史记录
Set-PSReadLineOption -PredictionSource History
# # 每次回溯输入历史，光标定位于输入内容末尾
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
# # 设置 Tab 为菜单补全和 Intellisense
Set-PSReadLineKeyHandler -Key "Tab" -Function MenuComplete
Set-PSReadLineKeyHandler -Key "Ctrl+p" -Function HistorySearchBackward # 设置向上键为后向搜索历史记录
Set-PSReadLineKeyHandler -Key "Ctrl+n" -Function HistorySearchForward # 设置向下键为前向搜索历史纪录
$Env:EDITOR='neovide'
Set-PsFzfOption -TabExpansion
Set-PsFzfOption -EnableAliasFuzzyEdit -EnableAliasFuzzyFasd -EnableAliasFuzzyHistory -EnableAliasFuzzyKillProcess -EnableAliasFuzzySetLocation -EnableAliasFuzzyScoop  -EnableAliasFuzzyZLocation -EnableAliasFuzzyGitStatus.
# eza
function Get-DirectoryContent
{
  eza --classify --color-scale --icons=always --group-directories-first --time-style iso @args
}
set-alias ls Get-DirectoryContent
function Get-DetailedDirectoryContent
{
  Get-DirectoryContent --long @args
}
set-alias ll Get-DetailedDirectoryContent
function Get-GitIgnoredDirectoryContent
{
  Get-DirectoryContent --git-ignore --git --git-repos @args
}
set-alias lsg Get-DetialedGitIgnoredDirectoryContent
function Get-DetialedGitIgnoredDirectoryContent
{
  Get-GitIgnoredDirectoryContent --long @args
}
set-alias llg Get-DetialedGitIgnoredDirectoryContent

# psfzf
Set-PsFzfOption -PSReadLineChordProvider ‘Ctrl+f’ -PSReadLineChordReverseHistory ‘Ctrl+r’
# fzf
# $Env:FZF_DEFAULT_COMMAND = 'fd --hidden --follow 
# -E ".git" 
# -E "node_modules" 
# -E ".cache" '
# fzf
$Env:FZF_DEFAULT_COMMAND = 'fd' 
$Env:FZF_DEFAULT_OPTS = '--height 90% 
--layout=reverse 
--bind=alt-j:down,alt-k:up,alt-i:toggle+down 
--border 
--preview "bat --color=always --style=numbers --line-range=:500 {}" 
--highlight-line 
--info=inline-right 
--ansi 
--color=bg+:#2d3f76 
--color=bg:#1e2030 
--color=border:#589ed7 
--color=fg:#c8d3f5 
--color=gutter:#1e2030 
--color=header:#ff966c 
--color=hl+:#65bcff 
--color=hl:#65bcff 
--color=info:#545c7e 
--color=marker:#ff007c 
--color=pointer:#ff007c 
--color=prompt:#65bcff 
--color=query:#c8d3f5:regular 
--color=scrollbar:#589ed7 
--color=separator:#ff966c 
--color=spinner:#ff007c 
'
$Env:CMAKE_GENERATOR='MinGW Makefiles'
$Env:RUNEWIDTH_EASTASIAN=0

Set-PSReadlineKeyHandler -Chord "Ctrl+f" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert('cd "$(fzf)\.."')
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}
Set-PSReadlineKeyHandler -Chord "Ctrl+e" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert('Get-ChildItem . -Recurse -Attributes !Directory | Invoke-Fzf | % { neovide $_ }')
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadlineKeyHandler -Chord "Ctrl+o" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert('explorer .')
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadlineKeyHandler -Chord "Ctrl+g" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert('lazygit')
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}
Set-PSReadlineKeyHandler -Chord "Ctrl+b" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert('cd -')
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

function y
{
  $tmp = [System.IO.Path]::GetTempFileName()
  yazi $args --cwd-file="$tmp"
  $cwd = Get-Content -Path $tmp
  if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path)
  {
    Set-Location -LiteralPath $cwd
  }
  Remove-Item -Path $tmp
}
Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })
fastfetch
