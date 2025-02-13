# 引入 ps-read-line
Import-Module PSReadLine
# 引入 PSFzf
Import-Module PSFzf

Set-alias 'sudo' 'gsudo'

# 引入 posh-git
Import-Module posh-git

Import-Module PSCompletions

# Import the catppuccin
Import-Module Catppuccin

# Set a flavor for easy access
$Flavor = $Catppuccin['Mocha']

# 设置预测文本来源为历史记录
Set-PSReadLineOption -PredictionSource History
# # 每次回溯输入历史，光标定位于输入内容末尾
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
# # 设置 Tab 为菜单补全和 Intellisense
#Set-PSReadLineKeyHandler -Key "Tab" -Function MenuComplete
Set-PSReadLineKeyHandler -Key "Ctrl+p" -Function HistorySearchBackward # 设置向上键为后向搜索历史记录
Set-PSReadLineKeyHandler -Key "Ctrl+n" -Function HistorySearchForward # 设置向下键为前向搜索历史纪录
Set-PSReadLineKeyHandler -Key "Ctrl+u" -Function BackwardDeleteInput # 删除到开头
Set-PSReadLineKeyHandler -Chord '"',"'" `
  -BriefDescription SmartInsertQuote `
  -LongDescription "Insert paired quotes if not already on a quote" `
  -ScriptBlock {
  param($key, $arg)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($line.Length -gt $cursor -and $line[$cursor] -eq $key.KeyChar)
  {
    # Just move the cursor
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
  } else
  {
    # Insert matching quotes, move cursor to be in between the quotes
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)" * 2)
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor - 1)
  }
}
Set-PSReadLineKeyHandler -Key '(','{','[' `
  -BriefDescription InsertPairedBraces `
  -LongDescription "Insert matching braces" `
  -ScriptBlock {
  param($key, $arg)

  $closeChar = switch ($key.KeyChar)
  {
    <#case#> '('
    { [char]')'; break 
    }
    <#case#> '{'
    { [char]'}'; break 
    }
    <#case#> '['
    { [char]']'; break 
    }
  }

  $selectionStart = $null
  $selectionLength = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($selectionStart -ne -1)
  {
    # Text is selected, wrap it in brackets
    [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, $key.KeyChar + $line.SubString($selectionStart, $selectionLength) + $closeChar)
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
  } else
  {
    # No text is selected, insert a pair
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)$closeChar")
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
  }
}

Set-PSReadLineKeyHandler -Key ')',']','}' `
  -BriefDescription SmartCloseBraces `
  -LongDescription "Insert closing brace or skip" `
  -ScriptBlock {
  param($key, $arg)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($line[$cursor] -eq $key.KeyChar)
  {
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
  } else
  {
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)")
  }
}

Set-PSReadLineKeyHandler -Key Backspace `
  -BriefDescription SmartBackspace `
  -LongDescription "Delete previous character or matching quotes/parens/braces" `
  -ScriptBlock {
  param($key, $arg)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($cursor -gt 0)
  {
    $toMatch = $null
    if ($cursor -lt $line.Length)
    {
      switch ($line[$cursor])
      {
        <#case#> '"'
        { $toMatch = '"'; break 
        }
        <#case#> "'"
        { $toMatch = "'"; break 
        }
        <#case#> ')'
        { $toMatch = '('; break 
        }
        <#case#> ']'
        { $toMatch = '['; break 
        }
        <#case#> '}'
        { $toMatch = '{'; break 
        }
      }
    }

    if ($toMatch -ne $null -and $line[$cursor-1] -eq $toMatch)
    {
      [Microsoft.PowerShell.PSConsoleReadLine]::Delete($cursor - 1, 2)
    } else
    {
      [Microsoft.PowerShell.PSConsoleReadLine]::BackwardDeleteChar($key, $arg)
    }
  }
}

$Colors = @{
  # Largely based on the Code Editor style guide
  # Emphasis, ListPrediction and ListPredictionSelected are inspired by the Catppuccin fzf theme
	
  # Powershell colours
  ContinuationPrompt     = $Flavor.Teal.Foreground()
  Emphasis               = $Flavor.Red.Foreground()
  Selection              = $Flavor.Surface0.Background()
	
  # PSReadLine prediction colours
  InlinePrediction       = $Flavor.Overlay0.Foreground()
  ListPrediction         = $Flavor.Mauve.Foreground()
  ListPredictionSelected = $Flavor.Surface0.Background()

  # Syntax highlighting
  Command                = $Flavor.Blue.Foreground()
  Comment                = $Flavor.Overlay0.Foreground()
  Default                = $Flavor.Text.Foreground()
  Error                  = $Flavor.Red.Foreground()
  Keyword                = $Flavor.Mauve.Foreground()
  Member                 = $Flavor.Rosewater.Foreground()
  Number                 = $Flavor.Peach.Foreground()
  Operator               = $Flavor.Sky.Foreground()
  Parameter              = $Flavor.Pink.Foreground()
  String                 = $Flavor.Green.Foreground()
  Type                   = $Flavor.Yellow.Foreground()
  Variable               = $Flavor.Lavender.Foreground()
}

# Set the colours
Set-PSReadLineOption -Colors $Colors

$Env:EDITOR='nvim'
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
--style full 
--tmux 80% 
--border --padding 1,2 
--border-label " FZF " --input-label " Input " --header-label " File Type " 
--bind "ctrl-r:change-list-label( Reloading the list )+reload(sleep 2; git ls-files)" 
--color "border:#aaaaaa,label:#cccccc" 
--color "preview-border:#9999cc,preview-label:#ccccff" 
--color "list-border:#669966,list-label:#99cc99" 
--color "input-border:#996666,input-label:#ffcccc" 
--color "header-border:#6699cc,header-label:#99ccff" 
--layout=reverse 
--bind=alt-j:down,alt-k:up,alt-i:toggle+down 
--preview "bat --color=always --style=numbers --line-range=:500 {}" 
--highlight-line 
--info=inline-right 
--ansi 
--layout=reverse 
--border=none
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
--multi
'
$Env:RUNEWIDTH_EASTASIAN=0

Set-PSReadlineKeyHandler -Chord "Ctrl+f" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert('cd "$(fzf)\.."')
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}
Set-PSReadlineKeyHandler -Chord "Ctrl+e" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert('nvim $(fzf)')
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadlineKeyHandler -Chord "Ctrl+o" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert('explorer .')
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}
function EP
{
  explorer.exe . 
}
set-alias ex EP 
set-alias lg lazygit

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
$Env:XDG_CONFIG_HOME=$Env:home+"\.config"
$Env:XDG_DATA_HOME  =$Env:home+"\.local\share"
$Env:XDG_STATE_HOME =$Env:home+"\.local\share"
$Env:NVIM_LOG_FILE  =$Env:home+"\.local\share"
$Env:_ZO_DATA_DIR   =$Env:home+"\.local\share\zoxide"
$Env:path += ";$Env:home/.config/fzf"
$Env:YAZI_CONFIG_HOME=$Env:home+"\.config\yazi"
$Env:scoop=$Env:home+"\scoop"
$Env:EZA_CONFIG_DIR = $Env:XDG_CONFIG_HOME+"\eza"
#设置代理
$Env:http_proxy="http://127.0.0.1:7890"
$Env:https_proxy="http://127.0.0.1:7890"
fastfetch
