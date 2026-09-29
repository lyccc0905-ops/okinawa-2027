---
updated: 2026-09-29
updated_by: Claude Code session 2026-09-29
latest_record: records/260929-entry-rules-and-day3.md
health: yellow   # 頁面渲染從未在瀏覽器實測；內容與資料已查核
---
<!-- flightwake STATE — 永遠短、永遠新。新 session 的第一站。 -->
<!-- 規則:只寫「現在」與「下一步」;歷史去 records/,決策去 DECISIONS.md。 -->
<!-- 冷啟動契約:讀完本檔 + latest_record 必須能在 5 分鐘內安全接手。 -->

# 現在在哪

沖繩 2027/3/25–3/28 行程網頁第一版已完成。唯一的檔案是 `index.html`，發佈在使用者的 claude.ai artifact（私人頁面，在使用者自己的 artifact 列表可以找到）。四天行程、營業時間、附近小店與甜點咖啡都填好了。住宿已訂 JR九州ホテル ブラッサム那覇，並獨立成「住宿」區塊。頁面上方順序為：入境提醒事項（含已查核的出入境規定）→ 航班 → 行李額度 → 住宿。Day 3 已拿掉美國村，晚餐改為那霸的うりずん。使用者會繼續逐站修改或新增。

# 進行中(未完成勿刪)

- [ ] 租車還沒訂：一定要選停得進飯店機械式停車場的車（高 2.1m、重 2 噸以下），例如 Noah／Voxy
- [ ] 餐廳還沒訂位：ゆうなんぎい、Seaside Drive-in、うりずん（電話都在 `todos` 的 booking 那一項）
- [ ] 還沒問飯店停車場能不能預約（寫在 `todos` 的 parking 那一項）
- [ ] 使用者要逐站檢視行程，可能換掉或刪掉景點
- [ ] 頁面渲染未實測（health 為 yellow 的原因）

# 下一步入口

1. 使用者要改行程 → 改 `index.html` 裡 `<script>` 的 `days` 陣列。每個 event 有 t/title/note/hours/type/map/shops/cafes 欄位，店家資料在 `SHOPS`、`CAFES` 物件。改完重新發佈到同一個 artifact，再 commit。
2. 新增店家或餐廳 → 先查證真實營業時間與公休日，並對照到訪的星期幾，再加進去。不要憑印象寫。
3. 使用者說「轉到 GitHub」→ 照 DECISIONS 2026-09-24「公開發佈」那條做。

# 常備事實(這個 repo 的 3-5 條保命知識)

- 同行 6 人，含 2 位長輩；租車；住 JR九州ホテル ブラッサム那覇（國際通旁）；晚餐一律排在 17:00–18:00。
- `index.html` 是 artifact 格式：沒有 `<!doctype>`、`<html>`、`<head>`，由 claude.ai 外包。放到一般網站前要補上。
- 匯率卡片讀 artifact 資料庫的 `rates/jpy`，由每天 08:00（台灣時間）的雲端排程寫入。離開 claude.ai 就讀不到，見 TRAPS `artifact-csp-no-fetch`。
- 營業時間都是依到訪的星期幾查核過的；3/28 是牧志公設市場公休日。
