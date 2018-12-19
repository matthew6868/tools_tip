# Git Tips

1. git proxy setting
> git config --global http.proxy http://192.168.80.222:3128

2. clone a specific branch
> git clone -b <branch> <remote_repo> 
> eg. git clone -b release/2.6 --single-branch https://github.com/FFmpeg/FFmpeg.git, --single-branch is used in version 1.7.10 and later to prevent fetching all of branches.

3. git core.autocrlf flag

4. 
> $ git pull<br>
Cannot pull with rebase: You have unstaged changes.
Please commit or stash them.
```shell
git status
git reset --hard
git stash
git stash pop/git stash apply stash@{0}
```

5. error: RPC failed; result=18, HTTP code = 0
> git config http.postBuffer 524288000 
> or git config --global http.postBuffer 524288000 for global setting

6. Windows 10下设置使用Beyond Compare diff/merge工具
6-1:<br>
添加Beyond Compare目录到path目录，确保命令行下面运行BCompare.exe/bcomp能够打开窗口。
6-2:<br>
> git config --global diff.tool bc3
> git config --global difftool.bc3.path "c:/Program Files/Beyond Compare 4/bcomp.exe"
注意这里一定要使用bcomp.exe而不要使用BCompare.exe，前面一个打开多个比较的时候使用多进程，后面的每打开一个比较都使用同一个进程，这样会导致打开失败的问题。
参考设置：
http://www.scootersoftware.com/support.php?c=kb_vcs.php

7. clone 一个远程仓库并保留所有历史信息到自己的仓库
```shell
$: git remote set-url origin <new-url> // 设置新仓库地址
$: git push --all -f // 推送所有本地分支到远端仓库
$: git remote show origin
$: git remote set-head origin <3.0>
```

### 新建一个远程分支
```shell
$: git branch -a
$: git checkout -b qamaster origin/qamaster
```

### 新建一个分支
1. 新建分支
> git branch qamaster

2. 切换分支
> git checkout qamaster

3. 同步分支
> git push origin qamaster 

4. 删除分支
> git branch -d qamaster

### 合并分支
1. 切换到待合并的分支
> git checkout qamaster

2. 合并分支并处理冲突
> git merge master

3. 推送到远端
> git push origin qamaster

### 合并指定commit id
1. 切换到待合并的分支
> git checkout qamaster

2. 合并指定commit id并处理冲突
> git cherry-pick cf5d4061ef9d5bc3f680561a219180ed674e1b97

3. 推送到远端
> git push origin qamaster

### 新建一个标签tag
1. 设置一个含注释的标签
> git tag -a v0.11 -m '0.11版本' 

2. 推送到远端服务器
> git push origin v0.11  
> git push origin tags //推送所有本地的tags

3. 删除标签
> git tag -d v0.11 //删除本地  
> git push origin --delete v0.11 //删除远程服务端
