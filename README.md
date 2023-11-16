## 简介
基于Pandora的,可自动刷新AccessToken的ChatGPT反向代理.
用于穿过中国GFW,美国Cloudflare,直连ChatGPT.提供HTTP访问和API访问

## 风险告知
由热心大佬提供Cloudflare反代服务,**你根据账号和密码生成的AccessToken会被发送到他的服务器里**.

[反代服务在线状态](https://status.fakeopen.com/)

## API

```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "你是谁",
    "message_id": "'$(uuidgen)'",
    "parent_message_id": "'$(uuidgen)'",
    "model": "text-davinci-002-render-sha",
    "timezone_offset_min": -480,
    "stream": false
  }' \
  http://127.0.0.1:3000/api/conversation/talk
```
集成进Python推荐使用[pandora-with-langchain_pandora-api-usage ](https://github.com/14790897/pandora-with-langchain_pandora-api-usage/blob/main/README.cn.md)

## 启动

1. `.env.example` 重命名为 `.env`
2. 将你的ChatGPT Username & Password 写进`.env`, 不支持Google/Microsoft/Apple账号OAuth2登录
3. 在有docker compose的前提下运行以下命令
```bash
# 编译 启动
docker compose build && docker compose up
curl http://127.0.0.1:3000
```
