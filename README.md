# felix cil

<!--toc:start-->

- [felix cil](#felix-cil)
  - [终端](#终端)
    - [powershell](#powershell)
    - [wezterm](#wezterm)
  - [软件管理](#软件管理)
    - [SCOOP](#scoop)
      - [安装路径](#安装路径)
      - [安装](#安装)
      - [软件包查找](#软件包查找)
      - [命令](#命令)
  - [终端命令](#终端命令)
  - [bat](#bat)
  - [fanyi](#fanyi)
  - [hexyl](#hexyl)
  - [glow](#glow)
  - [fzf](#fzf)
  - [psfzf](#psfzf)
  - [lazygit](#lazygit)
  - [neovim](#neovim)
  - [yazi](#yazi)
  <!--toc:end-->

## 终端

### powershell

- 安装

```powershell
winget search Microsoft.PowerShell                                 #搜索最新版本
winget install --id Microsoft.Powershell --source winget           #安装正式版
winget install --id Microsoft.Powershell.Preview --source winget   #安装预览版
```

- 配置

### wezterm

- 功能  
  终端模拟器

- 安装

```powershell
scoop install extras/wezterm
```

- 使用

```powershell
wezterm
```

- 配置

```powershell
git clone https://github.com/Wu-Felix/WezTerm.git $Env:home\.config\wezterm
```

## 软件管理

### SCOOP

#### 安装路径

用户安装路径：SCOOP  
 全局安装目录: SCOOP_GLOBAL

#### 安装

```powershell
#设置允许 PowerShell 执行本地脚本
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
#安装 Scoop
iwr -useb get.scoop.sh | iex
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

#### 软件包查找

[scoop](https://scoop.sh/#/)

#### 命令

- 安装命令

```powershell
scoop search <app>            #搜索软件
scoop install <app>           #安装软件
scoop install -k <app>        #安装软件,不保留包缓存
scoop info <app>              #查看软件详细信息
scoop list                    #查看已安装软件
scoop uninstall <app>         #卸载软件，-p删除配置文件
scoop update                  #更新 scoop 本体和软件列表
scoop update <app>            #更新指定软件
scoop update -k <app>         #升级软件,不保留包缓存
scoop update \*               #更新所有已安装的软件
scoop checkup                 #检查 scoop 的问题并给出解决问题的建议
```

- 清理安装包缓存

```powershell
scoop cache show              #显示安装包缓存
scoop cache rm <app>          #删除指定应用的安装包缓存
scoop cache rm *              #删除所有的安装包缓存
```

- 删除旧版本软件

```powershell
scoop cleanup <app>            #删除指定软件的旧版本
scoop cleanup *                #删除所有软件的旧版本
scoop cleanup -k <app>         #删除指定软件的旧版本并清除安装包缓存
scoop cleanup -k *             #删除所有软件的旧版本并清除安装包缓存
```

- 全局安装

```powershell
sudo scoop install -g <app>
sudo scoop update -g *         #更新所有软件（且包含全局软件）
sudo scoop uninstall -g <app>  #卸载全局软件
sudo scoop uninstall -gp <app> #卸载全局软件（并删除配置文件）
sudo scoop cleanup -g *        #删除所有全局软件的旧版本
sudo scoop cleanup -gk *       #删除所有全局软件的旧版本（并清除安装包包缓存）
```

## 终端命令

### bat

- 功能

- 安装

```powershell
scoop install bat
```

### fanyi

- 功能  
  终端翻译

- 安装

```powershell
npm i fanyi -g
```

- 使用

```powershell
fy word
```

- 配置

```powershell
 fanyi config list                          #list all configuration options
 fanyi config set iciba false               #disable iciba globally
 fanyi config set groq false                #disable groq globally
 fanyi config set color false               #disable color globally
 fanyi config set GROQ_API_KEY your-api-key #set GROQ_API_KEY
```

### hexyl

- 功能  
  二进制文件预览
- 安装

```powershell
scoop install main/hexyl
```

- 使用

```powershell
hexyl 文件
```

### glow

- 功能  
  markdown 预览
- 安装

```powershell
scoop install main/glow
```

- 使用

```powershell
glow
glow *.md  #打开md文件
```

### fzf

- 功能  
  模糊查找
- 安装

```powershell
scoop install main/fzf
```

- 使用

```powershell
fzf
```

### psfzf

- 功能  
  powershell 模糊查找
- 安装

```powershell
scoop install extras/psfzf
```

- 使用

```powershell
fzf
```

### lazygit

- 功能  
  git 客户端

- 安装

```powershell
scoop install extras/lazygit

```

- 使用

```powershell
lazygit

```

- 配置

```powershell
git clone https://github.com/Wu-Felix/lazygit.git $env:APPDATA\lazygit
```

### neovim

- 功能  
  编辑器

- 安装

```powershell
scoop install neovim
```

- 使用

```powershell
neovim
```

- 配置

```powershell
# 依赖 fzf lazygit ripgrep fd nerdfont
git clone https://github.com/Wu-Felix/nvim.git $env:LOCALAPPDATA\nvim
```

- 网址  
  [lazyvim](https://www.lazyvim.org/)

### yazi

- 功能  
  终端文件管理

- 安装

```powershell
scoop install main/yazi
```

- 使用

```powershell
y
ya pack -a <app> #安装插件
ya pack -l       #查看插件
ya pack -i       #安装管理插件
```

- 配置

```powershell
git clone https://github.com/Wu-Felix/yazi.git $env:APPDATA\yazi
ya pack -i #依赖 glow hexyl fzf
```

- 网址  
  [yazi](https://yazi-rs.github.io/)
