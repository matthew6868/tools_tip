1)git proxy setting
git config --global http.proxy http://192.168.80.222:3128

2)clone a specific branch
git clone -b <branch> <remote_repo> eg. git clone -b release/2.6 --single-branch https://github.com/FFmpeg/FFmpeg.git, --single-branch is used in version 1.7.10 and later to prevent fetching all of branches.

3)git core.autocrlf flag

4)
$ git pull
Cannot pull with rebase: You have unstaged changes.
Please commit or stash them.
==>
git status
git reset --hard
git stash
git stash pop/git stash apply stash@{0}

5)
error: RPC failed; result=18, HTTP code = 0
git config http.postBuffer 524288000 
or git config --global http.postBuffer 524288000 for global setting

6)
Windows 10下设置使用Beyond Compare diff/merge工具
6-1)
添加Beyond Compare目录到path目录，确保命令行下面运行BCompare.exe/bcomp能够打开窗口。
6-2)
git config --global diff.tool bc3
git config --global difftool.bc3.path "c:/Program Files/Beyond Compare 4/bcomp.exe"
注意这里一定要使用bcomp.exe而不要使用BCompare.exe，前面一个打开多个比较的时候使用多进程，后面的每打开一个比较都使用同一个进程，这样会导致打开失败的问题。
参考设置：
http://www.scootersoftware.com/support.php?c=kb_vcs.php

7) clone 一个远程仓库并保留所有历史信息到自己的仓库
git remote set-url origin <new-url> // 设置新仓库地址
git push --all -f // 推送所有本地分支到远端仓库
git remote show origin
git remote set-head origin <3.0>