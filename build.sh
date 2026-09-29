#!/bin/sh
# 把 claude.ai artifact 格式的 index.html 包成完整網頁，輸出到 docs/（GitHub Pages 從這裡發佈）
set -e
cd "$(dirname "$0")"
{
  printf '<!doctype html>\n<html lang="zh-Hant">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n<meta name="description" content="沖繩四天三夜行程表：2027/3/25–3/28，6 人自駕、住那霸國際通旁。">\n<style>html{color-scheme:light}:root{padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0}img{max-width:100%%}[hidden]{display:none!important}</style>\n</head>\n<body>\n'
  cat index.html
  printf '\n</body>\n</html>\n'
} > docs/index.html
echo "docs/index.html 已更新"
