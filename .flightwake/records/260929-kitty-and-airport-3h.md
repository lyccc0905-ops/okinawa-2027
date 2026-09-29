---
record_id: 260929-kitty-and-airport-3h
session: Claude Code session 2026-09-29
date: 2026-09-29
repos: [行程表/沖繩3-25-3-28]
tests: 無測試套件；頁面內 JS 用 node `new Function()` 檢查語法通過
prod_changes: claude.ai artifact 重新發佈 3 次（第 25–27 版）
---

# 飯店名不換行、加入 Kitty 店家、Day 4 提前 3 小時到機場

**TL;DR**：這次做了三件事。住宿卡片的飯店名稱改成不換行。國際通和那霸機場加上「Kitty・Sanrio」店家清單。使用者擔心退稅新制排隊，Day 4 改成 17:55（起飛前 3 小時）到機場，連帶把下午行程、晚餐（改 16:00）和還車時間都往前移。

## 關鍵發現（重要性排序）

1. **Kitty 商品主要在國際通，行程上其他站都沒有 Sanrio 直營店**：國際通有多間沖繩限定「日曬 Kitty」的官方販售點；那霸機場 Kitty 最齊的店「タイラ」在**國內線** 2F，國際線旅客要在報到前走連結通道過去。浦添 PARCO CITY 的 Sanrio Gift Gate 已經關店。
2. **提前到機場，晚餐就排不進 17–18 點**：Day 4 晚餐因此改成 16:00，是唯一的例外。→ 已記入 DECISIONS 2026-09-29。
3. 機場那一站寫明了辦理順序：退稅 → 報到託運 → 安檢出境。原因見 TRAPS `japan-taxfree-refund-2026`。

## 交付 / Commits

0459beb..c8e7403

## 驗證證據

- Kitty 店家來源：Sanrio 官方新聞頁與門市搜尋、ドン・キホーテ門市頁、飯店官網，查詢日期 2026-09-29。其中 Hotel Okinawa 商店的營業時間，各來源寫法不一，頁面上已註明。
- 頁面渲染仍未在瀏覽器實測，health 維持 yellow。

## 未完 / 交接

- 同 [[260929-entry-rules-and-day3]]。
