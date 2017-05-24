---
layout:     post
title:      "Shell练习与示范"
date:       2017-02-16 05:04:26 +0800
author:     "nick"
published: true
categories: Shell
---

## 文件批量重命名
> 根据输入的目标文件夹，首先列出该目录下所有子文件，然后遍历进行rename。

<!-- more -->

示范代码：

```shell
if [ -z "$1" ]; then
    echo "Usage: rename [TargetDir] [Prefix] [SubFix]"
    exit
fi

if [ "$1" = "." ]; then
    echo "Invalid target $1"
    exit
fi

TargetDir=$1;
echo "Target:${TargetDir}"

cd ${TargetDir} > /dev/null

if [ "1" = "$?" ]; then
    echo "Target $1 not exists"
    exit
fi

SubFiles=$(ls -m)


Tmp=TMPLATE

echo "$SubFiles" > $Tmp

Trimed=$(sed 's/[ ][ ]*//g' $Tmp)

echo "All sub files ${Trimed}"

echo "Now spliting pathes..."

index=1;
subFile=$(echo ${Trimed} | cut -d \, -f ${index})

echo "sub file $subFile"

while([ -n "$subFile" ])
do echo "Now handing file $subFile"
index=$[index+1]
subFile=$(echo $Trimed | cut -d \, -f $index)
done
```

