---
updated: 2026-10-01
updated_by: Claude Code session 2026-09-30
latest_record: records/261001-itoman-day3-light.md
health: yellow   # 桌機版已實測；手機寬度未實測
---
<!-- flightwake STATE — 永遠短、永遠新。新 session 的第一站。 -->
<!-- 規則:只寫「現在」與「下一步」;歷史去 records/,決策去 DECISIONS.md。 -->
<!-- 冷啟動契約:讀完本檔 + latest_record 必須能在 5 分鐘內安全接手。 -->

# 現在在哪

沖繩 2027/3/25–3/28 行程網頁第一版已完成。原始檔是 `index.html`（claude.ai artifact 格式）。發佈在兩個地方：一是使用者私人的 claude.ai artifact；二是公開的 GitHub Pages（GitHub 帳號 lyccc0905-ops 的公開 repo `okinawa-2027`，從 main 分支的 `docs/` 發佈）。四天行程、營業時間、附近小店與甜點咖啡都填好了。住宿已訂 JR九州ホテル ブラッサム那覇，並獨立成「住宿」區塊。頁面上方順序為：入境提醒事項（含已查核的出入境規定）→ 航班 → 行李額度 → 住宿。Day 1 午餐在糸滿魚市場（お魚センター），之後到瀨長島吃甜點、休息。Day 3 很輕鬆：9:30 達摩寺 → 10:30 PARCO CITY（在裡面吃午餐）→ 14:00 回飯店休息 → 17:30 うりずん；美國村、港川、King Tacos、海中道路、製鹽所都已拿掉。Day 4 早上國際通、壺屋由長輩自己決定要不要去，不去就留在飯店休息，11:00 集合退房；已拿掉 iias，波上宮保留，之後去大國藥妝小祿站前店（13:30–15:45，辦免稅），16:00 在旁邊的 AEON 那霸店 3F 吃晚餐。Day 4 改成提前 3 小時（17:55）到機場辦退稅，當天晚餐 16:00。國際通與機場有 Kitty 店家清單。另有手繪風地圖版 `docs/map.html`（只在 GitHub Pages 上，行程表標頭有連結過去）。長輩腳不方便，所以要爬坡或走很久的 6 個景點已移到頁面上的「待暫定行程」區（`index.html` 的 `pendingSpots`）；地圖版也同步拿掉了。使用者會繼續逐站修改或新增。

# 進行中(未完成勿刪)

- [ ] 租車還沒訂：一定要選停得進飯店機械式停車場的車（高 2.1m、重 2 噸以下），例如 Noah／Voxy
- [ ] 餐廳還沒訂位：ゆうなんぎい、Seaside Drive-in、うりずん（電話都在 `todos` 的 booking 那一項）
- [ ] Day 4 車停 AEON 那霸店、再去大國藥妝，這樣停可不可以還沒確認（大國 098-891-8444）
- [ ] 還沒問飯店停車場能不能預約（寫在 `todos` 的 parking 那一項）
- [ ] 使用者要逐站檢視行程，可能換掉或刪掉景點，或從「待暫定行程」挑回來（挪回 `days`，同時補回 map.html 的 `DAYS`）
- [ ] Day 2（北部）等家人看過再決定，三種改法見 latest_record 的「未完 / 交接」；使用者沒說之前不要動 Day 2
- [ ] 手機寬度的版面還沒實測（桌機版已在 2026-09-29 用瀏覽器從頭到尾檢查過，GitHub Pages 上線後也確認正常）

# 下一步入口

0. 每次改完 `index.html`：若行程站點有變，同步改 `docs/map.html` 的 `DAYS`；執行 `./build.sh` → commit → `git push origin HEAD:main`（用 lyccc0905-ops 帳號推送：`GH_TOKEN=$(gh auth token --user lyccc0905-ops)`，再加上 `-c credential.helper= -c credential.helper='!gh auth git-credential'`，前面那個空的 helper 不能省，見 TRAPS `git-push-osxkeychain-wins-over-gh-helper`）；claude.ai 那份也要重新發佈。

1. 使用者要改行程 → 改 `index.html` 裡 `<script>` 的 `days` 陣列。每個 event 有 t/title/note/hours/type/map/shops/cafes 欄位，店家資料在 `SHOPS`、`CAFES` 物件。改完重新發佈到同一個 artifact，再 commit。
2. 新增店家或餐廳 → 先查證真實營業時間與公休日，並對照到訪的星期幾，再加進去。不要憑印象寫。

# 常備事實(這個 repo 的 3-5 條保命知識)

- 同行 6 人，含 2 位長輩，長輩腳不方便：新景點要避開爬坡、階梯或要走很久的；逛街可以（能坐咖啡店或先回飯店）。租車；住 JR九州ホテル ブラッサム那覇（國際通旁）；晚餐一律排在 17:00–18:00。
- `index.html` 是 artifact 格式（沒有 `<!doctype>`、`<html>`、`<head>`）；公開網站用的 `docs/index.html` 一律由 `./build.sh` 產生，不要手改。
- 匯率卡片：在 claude.ai 讀 artifact 資料庫 `rates/jpy`（每天 08:00 雲端排程寫入）；在 GitHub Pages 直接抓公開匯率。見 TRAPS `artifact-csp-no-fetch`。
- 營業時間都是依到訪的星期幾查核過的；3/28 是牧志公設市場公休日。
