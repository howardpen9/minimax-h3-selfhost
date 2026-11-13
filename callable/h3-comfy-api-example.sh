#!/usr/bin/env bash
# MiniMax H3 Comfy API 呼叫範例（可交 HR）
# 前提：已 SSH 進自租的 Comfy 實例。只打本機埠，不要走公開隧道。
#   ssh -p <direct_port> root@<instance_ip>
# Comfy 本機入口：http://127.0.0.1:18188
set -euo pipefail

# 1) 健康檢查
curl -sS http://127.0.0.1:18188/system_stats | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('system',{}).get('comfyui_version'))"

# 2) 送出與冷首片相同的 I2V 工作流（5 秒、640x640、Turbo 關）
#    工作流 JSON 與本檔同目錄：h3-i2v-first-prompt.json
#    注意：若 JSON 與先前成功的那則完全相同，Comfy 會命中快取，約 0.02 秒結束並重用舊 mp4。
#    要真正再跑（熱機計時），先改節點 105:15 的 noise_seed，必要時改 92 的 filename_prefix。
RESP=$(curl -sS -X POST http://127.0.0.1:18188/prompt \
  -H "Content-Type: application/json" \
  --data-binary @"$(dirname "$0")/h3-i2v-first-prompt.json")
echo "$RESP"
PROMPT_ID=$(python3 -c "import json,sys; print(json.loads(sys.argv[1]).get('prompt_id',''))" "$RESP")
echo "prompt_id=$PROMPT_ID"

# 3) 看佇列
curl -sS http://127.0.0.1:18188/queue

# 4) 跑完後查歷史（把 <PROMPT_ID> 換成上一步的 id）
# curl -sS http://127.0.0.1:18188/history/<PROMPT_ID>
