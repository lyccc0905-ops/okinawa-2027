---
record_id: 260930-pages-and-map
session: Claude Code session 2026-09-29～30
date: 2026-09-30
repos: [行程表/沖繩3-25-3-28]
tests: 無測試套件；頁面內 JS 用 node `new Function()` 檢查語法通過；桌機版用瀏覽器實際檢視
prod_changes: 建立公開 GitHub repo okinawa-2027 並開啟 GitHub Pages（main 分支 /docs）；claude.ai artifact 重新發佈到第 30 版
---

# 頁面實測修版、發佈到 GitHub Pages 公開網址、新增可愛地圖版

**TL;DR**：這次做了三件事。第一次用瀏覽器實際檢視行程頁，修掉兩個排版問題：時間軸圓點貼住文字、收合箭頭太小。接著依使用者要求，把行程表發佈成可以給同事看的公開網址，用 GitHub Pages，帳號是 lyccc0905-ops。最後另外做了一頁手繪風的「地圖版」`docs/map.html`：全島地圖上用四種顏色標出每天的路線，加上那霸市區放大圖和每日行程卡片。

## 關鍵發現（重要性排序）

1. **claude.ai artifact 的頁面內容沒辦法用瀏覽器自動化捲動**：內容包在跨網域的框架裡，滑鼠滾輪和 PageDown 都沒反應。繞法是把 `index.html` 包成完整網頁，在本機開起來檢查。→ TRAPS `artifact-viewer-no-automated-scroll`
2. **SVG 元素如果掛了 CSS 動畫的 transform，原本寫在元素上的 transform 屬性（位置）會被整個蓋掉**：地圖上的鯨鯊、飛機、魚第一次全部跑到左上角。解法是外層 `<g>` 負責位置，內層 `<g>` 負責動畫。→ TRAPS `svg-css-animation-overrides-transform`
3. **這台電腦的 gh 預設帳號是使用者的另一個帳號，不是使用者要用來發佈的帳號**：推送時一律用 lyccc0905-ops 的 token，不動預設帳號。做法寫在 STATE「下一步入口」第 0 條。
4. **匯率卡片同一份程式碼兩邊都能用**：在 claude.ai 讀頁面資料庫；在 GitHub Pages 讀不到資料庫，就在網頁打開時直接抓公開匯率。已記入 DECISIONS 2026-09-29。
5. **那霸市區放大圖不照實際經緯度畫**：照實際位置畫，國際通一帶的圖釘會全疊在一起，機場和 iias 也會被切到畫面外，所以改成手動擺位置的示意圖。→ DECISIONS

## 交付 / Commits

ad7659e..6173f58

## 驗證證據

- 桌機寬度（約 1456px）從頭捲到尾截圖檢查，包括入境提醒、航班、行李、住宿、四天時間軸，以及展開後的店家與 Kitty 清單。修正後重新截圖，確認圓點和文字之間已經有間距。
- GitHub Pages 狀態回傳 `status=built`、`http=200`；頁面 `<title>` 是「沖繩 3/25–3/28」。
- 公開網址上的匯率卡片有抓到資料，顯示「1 円 ≈ NT$0.2014・9/28 更新」。在 GitHub Pages 上沒有頁面資料庫，所以這代表直接抓匯率的那段程式有正常運作。
- `map.html` 在本機檢查了三輪截圖，修正插圖位置、島嶼北端超出畫面、美麗海水族館和備瀨的圖釘重疊、那霸放大圖。上線後用 curl 確認網址回應中有「地圖版」字樣。
- **未驗證**：手機寬度的版面，行程表和地圖版都還沒看。

## 未完 / 交接

- 手機版面實測，以及 STATE「進行中」的訂車、訂位事項。行程之後有增刪時，`docs/map.html` 的 `DAYS` 要跟著改（它和 `index.html` 的 `days` 是兩份資料）。
