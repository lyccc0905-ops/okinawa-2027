---
record_id: 260924-okinawa-itinerary-v1
session: Claude Code session 2026-09-24
date: 2026-09-24
repos: [行程表/沖繩3-25-3-28]
tests: 無測試套件；每次改動後用 node `new Function()` 檢查頁面內 JS 語法通過
prod_changes: 發佈到 claude.ai artifact（私人頁面，共 18 版）；建立每日匯率雲端排程；寫入 artifact 資料庫 rates/jpy
---

# 沖繩 2027/3/25–3/28 行程表網頁第一版：航班、行李、四天行程、店家與每日匯率

**TL;DR**：起點只有兩張華航機票截圖。終點是單一檔案 `index.html` 的行程網頁，發佈在 claude.ai artifact 上。內容包括：去回程登機證卡片、行李額度、Visit Japan Web 連結、每日自動更新的日幣匯率、四天行程（每站附營業時間與 Google 地圖導航）、43 間附近小店、35 間甜點咖啡麵包店，以及出發前待辦。行程依 6 人同行、有兩位長輩、租車、住那霸、晚餐 17:00–18:00 的條件排定。之後打算轉成公開的 GitHub Pages。

## 關鍵發現（重要性排序）

1. **2027/3/28（日）第一牧志公設市場公休**：市場每月第 4 個週日公休（12 月除外），當天正好是第 4 個週日，二樓代客料理也一起休。Day 4 已改成午餐 Jack's Steak House、晚餐 iias 豐崎，市場移到 Day 1 晚上。→ TRAPS `makishi-market-4th-sunday`
2. **claude.ai artifact 頁面不能自己抓外部資料**：CSP 擋下所有 fetch，所以匯率改用 artifact 資料庫（db capability），由雲端排程寫入。→ TRAPS `artifact-csp-no-fetch`、DECISIONS
3. **雲端排程的對外連線有白名單**：open.er-api.com 和 cdn.jsdelivr.net 都被擋（connect_rejected），registry.npmjs.org 可以連。匯率改從 npm 下載 `@fawazahmed0/currency-api` 的 tarball。→ TRAPS `cloud-routine-egress-allowlist`
4. **ArtifactData 對已存在的文件 `set` 一定要帶 `if_version`**：沒帶會回 `version_mismatch`，什麼都不寫入。排程指令已改成先 get 再 set。→ TRAPS `artifactdata-set-needs-if-version`
5. 營業時間查核中排除的店：カフェくるくま（2025-10-31 永久歇業）、山の茶屋 楽水（週四公休）、Proots（週六公休）、taion（週日公休），以及其他時段對不上的店。資料來源為 2025–2026 年，頁尾已提醒出發前一週再確認。

## 交付 / Commits

cbf83c8..4e920dc（8 個 commit，由初版頁面到 Day 3 加入港川外人住宅）

## 驗證證據

- 匯率排程手動試跑 2 次。第 1 次因 open.er-api.com 被擋而失敗；改用 npm 來源後，第 2 次成功，排程狀態為 `ROUTINE_RUN_STATUS_SUCCEEDED`。資料庫 `rates/jpy` 寫入 twdPerJpy=0.20131618，資料日期 2026-09-23，文件版本 1→2。
- 以 `as_level: interact` 讀取 `rates/jpy` 有回傳資料，代表一般檢視者讀得到。
- 每次改動後，把頁面內的 `<script>` 放進 node 的 `new Function()` 檢查，語法都通過。
- **未驗證**：頁面的實際渲染（版面、深色模式、手機寬度、收合清單、日期導覽高亮）都沒有截圖或瀏覽器實測。使用者回報過兩次畫面問題（波浪線底部被裁切、日期高亮亂跳），都已修正，但修正後同樣沒有實測。

## 未完 / 交接

- 使用者要逐站檢視行程後再修改或新增（見 STATE「下一步入口」）。
- 住宿還沒訂，訂好後要加飯店名稱和停車資訊。
- 港川外人住宅只有 2 間店確認得到營業時間，可以再查。
- 轉 GitHub Pages 的步驟寫在 DECISIONS 2026-09-24 那一條。
