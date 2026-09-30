---
record_id: 260930-parco-daikoku
session: Claude Code session 2026-09-30
date: 2026-09-30
repos: [行程表/沖繩3-25-3-28]
tests: 無測試套件；兩頁的 JS 用 node `new Function()` 檢查語法通過；本機瀏覽器看過地圖版的全島圖與那霸放大圖
prod_changes: GitHub Pages 重建（448a8b1）；claude.ai artifact 第 32 版
---

# 加入 PARCO CITY 和大國藥妝小祿站前店

**TL;DR**：使用者給了兩個 Google 地圖短網址，要把 PARCO CITY 和一定要逛的大國藥妝排進行程。PARCO CITY 排在 Day 3，大國藥妝排在 Day 4。行程表、地圖版和兩個發佈點都已更新。

## 關鍵發現（重要性排序）

1. 短網址用 `curl -sIL -w %{url_effective}` 展開後，看得到店名和座標。PARCO CITY 在浦添，離港川外人住宅約 10 分車程。大國藥妝是那霸小祿站前店，在往機場的路上。排法見 DECISIONS 2026-09-30。
2. 營業時間：PARCO 10:00–22:00，停車免費（okinawastory 等來源）。大國藥妝 9:35–22:50，國定假日到 21:50，可辦免稅（官網店舗頁）。**大國藥妝的停車場還沒確認**，頁面上寫「附近有 AEON 那霸店停車場」，這一點也沒有查證。

## 交付 / Commits

c95b9a0..448a8b1

## 驗證證據

- 地圖版截圖：PARCO 和港川的圖釘與標籤沒有重疊；那霸放大圖上，大國藥妝的圖釘在機場和 iias 之間。
- GitHub Pages 建置 `built 448a8b1`，公開頁面 curl 抓得到新加的兩站。

## 未完 / 交接

- 大國藥妝的停車方式要確認：打電話 098-891-8444，或出發前查 Google 地圖。
