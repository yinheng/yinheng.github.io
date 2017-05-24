---
layout:     post
title:      "Linux find"
date:       2017/5/23 14:42:04 
author:     "Nick"
published: true
categories: Shell
---

Linux下find命令在目录结构中搜索文件，并执行指定的操作。Linux下find命令提供了相当多的查找条件，功能很强大。由于find具有强大的功能，所以它的选项也很多，其中大部分选项都值得我们花时间来了解一下。即使系统中含有网络文件系统( NFS)，find命令在该文件系统中同样有效，只你具有相应的权限。

运行一个非常消耗资源的find命令时，很多人都倾向于把它放在后台执行，因为遍历一个大的文件系统可能会花费很长的时间

<!-- more -->

### 用法: 

```
find [-H] [-L] [-P] [-Olevel] [-D help|tree|search|stat|rates|opt|exec] [path...] [expression]
```

### Help信息：
```
默认路径为当前目录；默认表达式为 -print
表达式可能由下列成份组成：操作符、选项、测试表达式以及动作：

操作符 (优先级递减；未做任何指定时默认使用 -and):
      ( EXPR )   ! EXPR   -not EXPR   EXPR1 -a EXPR2   EXPR1 -and EXPR2
      EXPR1 -o EXPR2   EXPR1 -or EXPR2   EXPR1 , EXPR2

位置选项 (总是真): -daystart -follow -regextype

普通选项 (总是真，在其它表达式前指定):
      -depth --help -maxdepth LEVELS -mindepth LEVELS -mount -noleaf
      --version -xdev -ignore_readdir_race -noignore_readdir_race

比较测试 (N 可以是 +N 或 -N 或 N): -amin N -anewer FILE -atime N -cmin N
      -cnewer 文件 -ctime N -empty -false -fstype 类型 -gid N -group 名称
      -ilname 匹配模式 -iname 匹配模式 -inum N -ipath 匹配模式 -iregex 匹配模式
      -links N -lname 匹配模式 -mmin N -mtime N -name 匹配模式 -newer 文件
      -nouser -nogroup -path PATTERN -perm [-/]MODE -regex PATTERN
      -readable -writable -executable
      -wholename PATTERN -size N[bcwkMG] -true -type [bcdpflsD] -uid N
      -used N -user NAME -xtype [bcdpfls]
      -context 文本


操作: -delete -print0 -printf 格式 -fprintf 文件 格式 -print
      -fprint0 文件 -fprint 文件 -ls -fls 文件 -prune -quit
      -exec 命令 ; -exec 命令 {} + -ok 命令 ;
      -execdir 命令 ; -execdir 命令 {} + -okdir 命令 ;

```

### 常用命令参数

* path: find命令所查找的目录路径。例如用.来表示当前目录，用/来表示系统根目录。
  
例如：
```find ./```

输出：
```
.
./1970-01-01-Style-Test.md
./2017-02-17-JAVA-TEST.markdown
./2017-05-12-GitDoc.markdown
./2017-05-15-Android-Audio-Overview.markdown
./2017-05-15-Audio-Terminology.markdown
./2017-05-16-Android-Audio-Implementation-Configuring-Audio-Policies.markdown
./2017-05-16-Android-Audio-Implementation-Overview.markdown
./2017-05-16-Shell-Test.markdown
./2017-05-17-Set-up-Git-Server.markdown
./2017-05-20-Java-Prac.markdown
./2017-05-23-Linux-Find.markdown
./create.sh
./publish.sh
./yyyy-mm-dd-TEMPLATE.markdown
```
当前目录下所有文件被列举出来。

 
* -print： find命令将匹配的文件输出到标准输出。（默认）

例如：``` find . -print``` 效果同上的``` find .```


* -exec： find命令对匹配的文件执行该参数所给出的shell命令。相应命令的形式为'command' {  } \;，注意{   }和\；之间的空格。 

例如：
```find publish.sh -exec cat {} \;```

输出了该文件的内容：
```
git pull
git add .
git commit -m "New blog"
git push origin master
```

* -ok： 和-exec的作用相同，只不过以一种更为安全的模式来执行该参数所给出的shell命令，在执行每一个命令之前，都会给出提示，让用户来确定是否执行。

例如：
```find publish.sh -ok cat {} \;```

输出：
```
< cat ... publish.sh > ?
```
输入```yes```回车，输出了文件内容：
```
git pull
git add .
git commit -m "New blog"
git push origin master
```

### 命令选项
```
-name   filename             #查找名为filename的文件
-perm                        #按执行权限来查找
-user    username             #按文件属主来查找
-group groupname            #按组来查找
-mtime   -n +n                #按文件更改时间来查找文件，-n指n天以内，+n指n天以前
-atime    -n +n               #按文件访问时间来查GIN: 0px">
-ctime    -n +n              #按文件创建时间来查找文件，-n指n天以内，+n指n天以前
-nogroup                     #查无有效属组的文件，即文件的属组在/etc/groups中不存在
-nouser                     #查无有效属主的文件，即文件的属主在/etc/passwd中不存
-newer   f1 !f2              找文件，-n指n天以内，+n指n天以前 
-ctime    -n +n               #按文件创建时间来查找文件，-n指n天以内，+n指n天以前 
-nogroup                     #查无有效属组的文件，即文件的属组在/etc/groups中不存在
-nouser                      #查无有效属主的文件，即文件的属主在/etc/passwd中不存
-newer   f1 !f2               #查更改时间比f1新但比f2旧的文件
-type    b/d/c/p/l/f         #查是块设备、目录、字符设备、管道、符号链接、普通文件
-size      n[c]               #查长度为n块[或n字节]的文件
-depth                       #使查找在进入子目录前先行查找完本目录
-fstype                     #查更改时间比f1新但比f2旧的文件
-type    b/d/c/p/l/f         #查是块设备、目录、字符设备、管道、符号链接、普通文件
-size      n[c]               #查长度为n块[或n字节]的文件
-depth                       #使查找在进入子目录前先行查找完本目录
-fstype                      #查位于某一类型文件系统中的文件，这些文件系统类型通常可 在/etc/fstab中找到
-mount                       #查文件时不跨越文件系统mount点
-follow                      #如果遇到符号链接文件，就跟踪链接所指的文件
-cpio                %;      #查位于某一类型文件系统中的文件，这些文件系统类型通常可 在/etc/fstab中找到
-mount                       #查文件时不跨越文件系统mount点
-follow                      #如果遇到符号链接文件，就跟踪链接所指的文件
-cpio                        #对匹配的文件使用cpio命令，将他们备份到磁带设备中
-prune                       #忽略某个目录
```

### 实例

**使用name选项**

* 文件名选项是find命令最常用的选项，要么单独使用该选项，要么和其他选项一起使用。可以使用某种文件名模式来匹配文件，记住要用引号将文件名模式引起来。不管当前路径是什么，如果你想要在自己的根目录$HOME中查找文件名符合*.log的文件，使用~作为 'pathname'参数，波浪号~代表了你的$HOME目录。

```find ~ -name "*.log" -print```

**表示  通配任意的字符　   
？表示  通配任意的单个字符*

* 想要在当前目录及子目录中查找所有的*.log文件，可以用：
 
```find . -name "*.log" -print```

* 想要的当前目录及子目录中查找文件名以一个大写字母开头的文件，可以用：  

```find . -name "[A-Z]*" -print```

*[ ] 表示 通配括号里面的任意一个字符*


* 想要在/etc目录中查找文件名以host开头的文件，可以用：  

```find /etc -name "host*" -print  ```

* 如果想在当前目录查找文件名以一个个小写字母开头，最后是4到9加上.log结束的文件：  

```find . -name "[a-z]*[4-9].log" -print```
输出：
```
./script/hs_err_pid32186.log
./script/hs_err_pid19725.log
./script/hs_err_pid5736.log
```

**用perm选项：**

按照文件权限模式用-perm选项,按文件权限模式来查找文件的话。最好使用八进制的权限表示法。  

如在当前目录下查找文件权限位为755的文件，即文件属主可以读、写、执行，其他用户可以读、执行的文件，可以用：  

```find . -perm 755 -print```

还有一种表达方法：在八进制数字前面要加一个横杠-，表示都匹配，如-007就相当于777，-005相当于555。




----------



**忽略某个目录：**

如果在查找文件时希望忽略某个目录，因为你知道那个目录中没有你所要查找的文件，那么可以使用-prune选项来指出需要忽略的目录。在使用-prune选项时要当心，因为如果你同时使用了-depth选项，那么-prune选项就会被find命令忽略。如果希望在test目录下查找文件，但不希望在test/test3目录下查找，可以用：  

命令：

```find app/  -path "app/src" -prune -o -name *.png -print```

在app目录下寻找所有png文件，忽略"app/src"文件夹。