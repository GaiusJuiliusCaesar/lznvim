# Introduction

This is my personal NeoVim customized settings. You can download and modify according to your needs.

# Prerequisites

- Make sure you install the following packages before proceeding with clone.

# Environment Variables

```bash
# For Jenkinsfile Validator Plugin
$ export JENKINS_URL="https://localhost/jenkins/"
$ export JENKINS_API_TOKEN="************************************"
$ export JENKINS_INSECURE=true
```

```bash
# MacOS X | WSL
$ brew install curl neovim fzf the_silver_searcher xclip
$ brew install nodejs ruby perl cpanm libtool make cmake libffi libxml2 libxslt readline
$ brew install rg fd lazygit golang
$ python3 -m pip install pynvim --user
$ npm install -g neovim
$ cpanm -n Neovim::Ext
$ cpanm -n App::cpanminus
$ PATH="$(gem environment user_gemhome)/bin:$(gem environment gemdir)/bin:$PATH"
$ export PATH
$ export DISPLAY=localhost:0.0
$ gem install neovim --user
```

```bash
# Fedora Linux
$ sudo dnf groupinstall "Development Tools"
$ sudo dnf -y install curl neovim fzf the_silver_searcher python3-neovim xclip libxml2-devel libxslt-devel
```

```bash
# RHEL | CentOS 8
$ sudo dnf groupinstall "Development Tools"
$ sudo dnf -y install curl neovim fzf the_silver_searcher python3-neovim xclip
```

# Download and Install

- Clone the my git repository as following.

```bash
$ git clone git@github.com:GaiusJuiliusCaesar/lznvim.git $HOME/.config/nvim
```

- Now, you can start using the Neovim

______________________________________________________________________

**NOTE:**

> **NeoVim** and its **Plugins** have its own respective license.

______________________________________________________________________
