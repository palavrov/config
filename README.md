# About
dotfiles repo

# Install
```bash
curl -H 'Cache-Control: no-cache' -Lks http://raw.githubusercontent.com/palavrov/config/ubuntu/linux_setup.sh | /bin/bash
```
# WARNING
Vim plugins are installed as git submodules. By default git creates them with full path:
```
	path = /Users/palavrov/.vim/pack/common/start/vim-fugitive
```
which is causes `git submodule update --init --recursive'` to fail with `fatal: No url found for submodule path '.vim/pack/common/start/MatchTagAlways' in .gitmodules`. To fix it change the path like that:
```
	path = .vim/pack/common/start/vim-fugitive
```

# Links
https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
https://news.ycombinator.com/item?id=11071754

https://github.com/mathiasbynens/dotfiles/blob/master/.macos
https://github.com/drduh/macOS-Security-and-Privacy-Guide
