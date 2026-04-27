#!/bin/bash

# 读取123文件中的每一行
while IFS= read -r line; do
  # 提取URL（使用cut提取单引号之间的部分）
  url=$(echo "$line" | cut -d"'" -f2)
  
  # 提取相对路径（去掉基准URL）
  path=$(echo "$url" | sed 's|https://doctrine-of-signatures.net/||')
  
  # 跳过目录（以/结尾的）
  if [[ "$path" == */ ]]; then
    echo "Skipping directory: $path"
    continue
  fi
  
  # 创建目录
  mkdir -p "$(dirname "$path")"
  
  # 下载文件到指定路径
  curl -o "$path" "$url"
  
  echo "Downloaded: $path"
done < target/static-resource-list.txt