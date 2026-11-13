# MiniMax H3 自租部署证据（2026-11-10）

本仓库存放在 Vast.ai RTX 4090 上自租部署 MiniMax-H3 的可调用脚本、工作流、成片和账单证据。部署方式是 Vast Comfy 模板（容器）加上 [Comfy-Org/MiniMax-H3](https://github.com/Comfy-Org/MiniMax-H3) 量化权重，在实例本机 `http://127.0.0.1:18188` 调用 Comfy API。这与 MiniMax 官方 API 或 SGLang BF16 不是同一条路径。

实例 `60008311` 已 Destroy，没有可供在线点击测试的公网地址。本仓库不含隧道网址、SSH 私钥或 Jupyter token，也不托管权重文件。

方案正文由本人另行改写后通过邮件提交，不放在本仓库。

## 可调用方式

- [`callable/h3-comfy-api-example.sh`](callable/h3-comfy-api-example.sh)：对本机 `http://127.0.0.1:18188` 做 `/system_stats`、`POST /prompt`、`/queue`，并说明如何查询 `/history/<PROMPT_ID>`
- [`callable/h3-i2v-first-prompt.json`](callable/h3-i2v-first-prompt.json)：与冷首片相同的 I2V 工作流（640×640、5 秒、Turbo 关闭）

本次实测没有另存 `POST /prompt` 返回的 `prompt_id` 或 `/history` JSON。[`evidence/h3-warm-x3-times.md`](evidence/h3-warm-x3-times.md) 中的 JobID 是当时记录的墙钟任务编号，尚未核对其是否等于 Comfy `prompt_id`。两则成片 mp4 内嵌了完整 workflow JSON（workflow id `e3f2b845-8f2c-4b5a-9caf-eac1029d3e7e`），seed 为 `757358688076805`。

## 输出

- [`outputs/MiniMax_H3_00001_.mp4`](outputs/MiniMax_H3_00001_.mp4)：主线 I2V，640×640，5.17 秒，24fps，AAC
- [`outputs/MiniMax_H3_00002_.mp4`](outputs/MiniMax_H3_00002_.mp4)：官方模板短 T2V 旁路，864×480，不当主线对照

官方首帧素材（未重新托管）：[transparent_rgb_gaming_mouse.png](https://raw.githubusercontent.com/Comfy-Org/workflow_templates/refs/heads/main/input/transparent_rgb_gaming_mouse.png)

## 账单与环境

2026-11-10 账上可见合计 **$2.44**（详见裁切后的 Transaction History 截图与费用表）。主实例 `60008311` 为 $2.35，其中下载 49.7GB 为 $1.94。机器为 RTX 4090，显存 24564 MiB，ComfyUI 0.43.0。冷首片墙钟 94.22 秒，热机三次平均 87.29 秒。

主线分辨率是 640×640，不能与官方 H3 768P 直接当成同一产品比价。

## 目录

```
callable/     调用脚本与 I2V 工作流 JSON
evidence/     启动报告、费用表、热机墙钟
outputs/      两则成片
screenshots/  账单（已裁账户侧栏）、94.22 秒实例日志（已裁）、12:03 成片画面、12:10 官方模板库
```

截图文件：

- [`screenshots/2026-11-12-vast-billing-cropped.png`](screenshots/2026-11-12-vast-billing-cropped.png)
- [`screenshots/2026-11-10-1244-instance-logs-94s-cropped.png`](screenshots/2026-11-10-1244-instance-logs-94s-cropped.png)
- [`screenshots/2026-11-10-1203-t2v-output.png`](screenshots/2026-11-10-1203-t2v-output.png)
- [`screenshots/2026-11-10-1210-template-library.png`](screenshots/2026-11-10-1210-template-library.png)
