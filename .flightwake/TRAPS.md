<!-- flightwake TRAPS — 坑 registry。非顯而易見、會再咬人的事實。 -->
<!-- 條目採 OKF 式慣例:frontmatter 區塊 + 內文;可用 [[名稱]] 互連。新的加最上面。 -->
<!-- 時效:條目過時(功能合併/重構後不再成立)不刪 — status 改 superseded 並指向取代者;讀的人只信 active。 -->
<!-- 證據強度:confidence 標的是「根因」的把握度,不是症狀。**不對稱門檻**——拿這條論證
     「這樣會壞」probable 就夠(錯了只是多做防護);論證「這樣是安全的」必須 confirmed
     (錯了直接打到 prod 和使用者)。 -->

# 坑 Registry

---
name: git-push-osxkeychain-wins-over-gh-helper
type: gotcha
status: active
confidence: probable
tags: [git, gh, 發佈, GitHub Pages]
discovered: 2026-09-30
---

**症狀**：用 `GH_TOKEN=$(gh auth token --user lyccc0905-ops) git -c credential.helper='!gh auth git-credential' push origin HEAD:main` 推送，回傳 `remote: Permission to lyccc0905-ops/okinawa-2027.git denied to yuntian-source.` / `The requested URL returned error: 403`。
**根因**：系統層 gitconfig（`/Library/Developer/CommandLineTools/usr/share/git-core/gitconfig`）已經設了 `credential.helper=osxkeychain`。`-c credential.helper=...` 只會加在清單後面，git 先問 osxkeychain，拿到另一個帳號 yuntian-source 存著的密碼就直接用了。只有「失敗一次、改法後成功一次」這一組對照。
**繞法**：先用空字串清掉 helper 清單，再加 gh：`git -c credential.helper= -c credential.helper='!gh auth git-credential' push ...`。2026-09-30 用這個寫法推送成功（52328f3）。
**佐證**：record [[260930-elder-friendly]]

---
name: svg-css-animation-overrides-transform
type: gotcha
status: active
confidence: confirmed
tags: [svg, css, 地圖版]
discovered: 2026-09-29
---

**症狀**：`docs/map.html` 裡的鯨鯊、飛機、魚、帆船，全部畫在 SVG 的左上角（原點），沒有出現在指定的位置。
**根因**：這些 `<g>` 同時有 `transform="translate(...)"` 屬性和 CSS 動畫 `.bob`（`transform: translateY`）。CSS 的 transform 會整個取代 SVG 的 transform 屬性。
**解法/繞法**：拆成兩層：外層 `<g transform="translate(...)">` 負責位置，內層 `<g class="bob">` 負責動畫。改完重看，四個插圖都回到正確位置。
**佐證**：commit 6173f58；record [[260930-pages-and-map]]

---
name: artifact-viewer-no-automated-scroll
type: gotcha
status: active
confidence: probable
tags: [claude-artifact, 瀏覽器自動化, 驗證]
discovered: 2026-09-29
---

**症狀**：用 Chrome 自動化打開 claude.ai artifact 頁面，滑鼠滾輪、PageDown、點日期列的錨點都沒辦法捲動，只看得到第一個畫面。
**根因**：artifact 的內容放在跨網域的框架裡，自動化的輸入和 JS 都碰不到裡面。這是推測，沒有做對照實驗。
**繞法**：把 `index.html` 包成完整 HTML（跟 `build.sh` 做的事一樣），在本機用 `python3 -m http.server` 開起來，再用 `window.scrollTo({behavior:"instant"})` 跳到各區塊截圖。頁面本身有 `scroll-behavior: smooth`，不加 instant 的話，截圖會拍到捲動到一半的畫面。
**佐證**：record [[260930-pages-and-map]]

---
name: japan-taxfree-refund-2026
type: constraint
status: active
confidence: probable
tags: [退稅, 那霸機場, 行程]
discovered: 2026-09-29
---

**症狀**：以前的經驗是「在店裡直接免稅」，但 2027 年 3 月去已經不是這樣。
**根因**：日本免稅在 2026-11-01 改成退稅制。店裡先付含稅價，出境時要在「託運行李之前」到機台（或用 Visit Japan Web）辦確認，才會退稅。消耗品在日本用掉，整張收據都不能退。
**繞法**：Day 4 到機場的提醒已加上「託運前先辦退稅確認」。實際退款方式和那霸機台的位置，出發前再查觀光廳頁面。
**佐證**：觀光廳旅客專頁（2026-09-29 查詢）；制度才剛上路，所以標 probable。

---
name: makishi-market-4th-sunday
type: constraint
status: active
confidence: confirmed
tags: [營業時間, 那霸, 行程]
discovered: 2026-09-24
---

**症狀**：原本排在 2027-03-28（日）去第一牧志公設市場吃二樓代客料理，查核後發現那天公休。
**根因**：市場每月第 4 個週日公休（12 月除外），另外 1/1–3、農曆新年、舊盆後兩天也休；二樓餐廳在同一棟，一起休。
**解法/繞法**：排市場前先算當月第幾個週日。這次改到 3/25（四）晚上去。豬肉蛋飯糰牧志市場店在建築外，不受影響。
**佐證**：市場官網 guide 頁；record [[260924-okinawa-itinerary-v1]]

---
name: artifact-csp-no-fetch
type: constraint
status: active
confidence: confirmed
tags: [claude-artifact, 匯率]
discovered: 2026-09-24
---

**症狀**：claude.ai artifact 頁面裡對外部 API 的 fetch 會被擋，也不會出現錯誤畫面。
**根因**：artifact 的 CSP 只允許少數 CDN 載入 script，其他 fetch、XHR 一律封鎖。
**解法/繞法**：動態資料放 artifact 資料庫（db capability），頁面用 `claude.use("db")` 讀，由外部（雲端排程或 ArtifactData）寫入。轉到 GitHub Pages 後沒有這個限制，也讀不到 db，要改成頁面直接抓。
**佐證**：Artifact 工具的頁面規範；record [[260924-okinawa-itinerary-v1]]

---
name: cloud-routine-egress-allowlist
type: gotcha
status: active
confidence: confirmed
tags: [雲端排程, 網路]
discovered: 2026-09-24
---

**症狀**：雲端排程裡執行 `curl`，結果是 `Exit code 56 [agent-proxy] ... connect_rejected (the egress proxy denied the CONNECT ...)`。
**根因**：雲端排程的對外連線有白名單。open.er-api.com 和 cdn.jsdelivr.net 被拒，registry.npmjs.org 放行。兩個被擋的網域在兩次獨立執行中各被拒一次。
**解法/繞法**：資料改從 npm registry 取得（下載套件 tarball 再解壓讀 JSON）。其他網域要先試跑一次，確認連得到。
**佐證**：排程第 1、2 次試跑的 run log；record [[260924-okinawa-itinerary-v1]]

---
name: artifactdata-set-needs-if-version
type: gotcha
status: active
confidence: probable
tags: [claude-artifact, 資料庫]
discovered: 2026-09-24
---

**症狀**：`ArtifactData set` 寫入一個已存在的文件時回傳 `db write failed (version_mismatch): rates/jpy already exists and this write carried no if_version — nothing was written`。
**根因**：文件已存在時，寫入必須帶上最後讀到的 `version` 作為 `if_version`。
**繞法**：先 `get` 取得 version，再用 `set` 加上 `if_version`；遇到 version_mismatch 就重新 get 一次再寫。排程指令已照這樣寫。
**佐證**：排程第 2 次試跑的 run log（只觀察到一次，所以標 probable）；record [[260924-okinawa-itinerary-v1]]

---
name: {{kebab-case-slug}}
type: trap          # trap | gotcha | constraint
status: active      # active | superseded(過時不刪,改此欄並在內文指向 [[取代條目]] 或 record)
confidence: suspected  # confirmed(受控實驗坐實:改變因 → 症狀跟著出現/消失,至少兩次;
                       #           非因果事實則為「窮盡查證 + 指得出一手來源」)
                       # probable(多次觀察一致,但沒做對照組)
                       # suspected(單次觀察,或「當下最像的解釋」)
                       # 未標此欄 = unknown(舊條目),讀的人比照 suspected 對待
tags: [{{標籤}}]
discovered: {{YYYY-MM-DD}}
---

**症狀**:{{看到什麼(錯誤訊息/怪行為)——這欄永遠是事實,錯誤訊息照貼}}
**根因**:{{一句話。confidence 標的就是這一欄的把握度}}
**解法/繞法**:{{怎麼處理。非 confirmed 時只寫「繞法」,不寫「解法」,也不得當行為準則}}
**佐證**:{{commit/record 連結;標 confirmed 必須指得出受控實驗}}
