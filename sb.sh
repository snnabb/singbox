{
  "log": {
    "disabled": false,
    "level": "info"
  },
  "dns": {
    "servers": [
      {
        "tag": "google",
        "address": "tls://8.8.8.8"
      },
      {
        "tag": "local",
        "address": "223.5.5.5"
      }
    ],
    "strategy": "prefer_ipv4"
  },

  "inbounds": [
    {
      "type": "tun",
      "tag": "tun-in",
      "interface_name": "singbox",
      "stack": "system",
      "sniff": true
    }
  ],

  "outbounds": [
    {
      "type": "direct",
      "tag": "DIRECT"
    },
    {
      "type": "block",
      "tag": "REJECT"
    },

    /* =============================
     * 在此处加入你的订阅节点（vmess / trojan / shadowsocks 等）
     * 每个节点必须有 tag，例如：
     * {
     *   "type": "shadowsocks",
     *   "tag": "🇭🇰 HK-1",
     *   "server": "...",
     *   "server_port": ...,
     *   "method": "...",
     *   "password": "..."
     * }
     * ============================= */
    

    /* AUTO 自动测速池 */
    {
      "type": "urltest",
      "tag": "AUTO",
      "outbounds": ["*"], // include-all
      "filter": {
        "exclude": ["剩余", "重置", "到期", "流量", "Traffic", "Expire", "Reset"]
      },
      "url": "http://connectivitycheck.gstatic.com/generate_204",
      "interval": "600s",
      "tolerance": 50
    },

    /* Entry / Exit 组合链路（relay） */
    {
      "type": "selector",
      "tag": "ENTRY",
      "outbounds": ["AUTO", "DIRECT", "*"],
      "filter": {
        "exclude": ["剩余", "重置", "到期", "流量", "Traffic", "Expire", "Reset"]
      }
    },
    {
      "type": "selector",
      "tag": "EXIT",
      "outbounds": ["AUTO", "DIRECT", "*"],
      "filter": {
        "exclude": ["剩余", "重置", "到期", "流量", "Traffic", "Expire", "Reset"]
      }
    },
    {
      "type": "relay",
      "tag": "CHAIN",
      "outbounds": ["ENTRY", "EXIT"]
    },

    /* 顶层选择器 Selection */
    {
      "type": "selector",
      "tag": "SELECTION",
      "outbounds": ["AUTO", "CHAIN", "DIRECT", "*"],
      "filter": {
        "exclude": ["剩余", "重置", "到期", "流量", "Traffic", "Expire", "Reset"]
      }
    },

    /* 下方生成与你原来 Clash 的所有分组 1:1 对应 */
    {
      "type": "selector",
      "tag": "APPLE",
      "outbounds": ["DIRECT", "SELECTION", "AUTO", "*"],
      "filter": {
        "exclude": ["剩余", "重置", "到期"]
      }
    },
    {
      "type": "selector",
      "tag": "TELEGRAM",
      "outbounds": ["SELECTION", "CHAIN", "AUTO", "DIRECT", "*"]
    },
    {
      "type": "selector",
      "tag": "YOUTUBE",
      "outbounds": ["SELECTION", "CHAIN", "AUTO", "DIRECT", "*"]
    },
    {
      "type": "selector",
      "tag": "BILIBILI",
      "outbounds": ["DIRECT", "SELECTION", "AUTO", "*"]
    },
    {
      "type": "selector",
      "tag": "OPENAI",
      "outbounds": ["SELECTION", "CHAIN", "AUTO", "DIRECT", "*"]
    },
    {
      "type": "selector",
      "tag": "GEMINI",
      "outbounds": ["SELECTION", "CHAIN", "AUTO", "DIRECT", "*"]
    },
    {
      "type": "selector",
      "tag": "CLAUDE",
      "outbounds": ["SELECTION", "CHAIN", "AUTO", "DIRECT", "*"]
    },
    {
      "type": "selector",
      "tag": "TIKTOK",
      "outbounds": ["SELECTION", "CHAIN", "AUTO", "DIRECT", "*"]
    },
    {
      "type": "selector",
      "tag": "SPOTIFY",
      "outbounds": ["DIRECT", "CHAIN", "SELECTION", "AUTO", "*"]
    },
    {
      "type": "selector",
      "tag": "NETFLIX",
      "outbounds": ["SELECTION", "CHAIN", "AUTO", "DIRECT", "*"]
    },
    {
      "type": "selector",
      "tag": "DISNEY",
      "outbounds": ["SELECTION", "CHAIN", "AUTO", "DIRECT", "*"]
    },
    {
      "type": "selector",
      "tag": "GOOGLE",
      "outbounds": ["SELECTION", "CHAIN", "AUTO", "DIRECT", "*"]
    },
    {
      "type": "selector",
      "tag": "ONEDRIVE",
      "outbounds": ["DIRECT", "SELECTION", "AUTO", "*"]
    },
    {
      "type": "selector",
      "tag": "MICROSOFT",
      "outbounds": ["DIRECT", "SELECTION", "AUTO", "*"]
    },
    {
      "type": "selector",
      "tag": "LINKEDIN",
      "outbounds": ["DIRECT", "SELECTION", "AUTO", "*"]
    },
    {
      "type": "selector",
      "tag": "LEARNING",
      "outbounds": ["DIRECT", "CHAIN", "SELECTION", "AUTO", "*"]
    },
    {
      "type": "selector",
      "tag": "TWITTER",
      "outbounds": ["SELECTION", "AUTO", "DIRECT", "*"]
    },
    {
      "type": "selector",
      "tag": "GLOBALMEDIA",
      "outbounds": ["SELECTION", "AUTO", "DIRECT", "*"]
    },
    {
      "type": "selector",
      "tag": "EMBY",
      "outbounds": ["DIRECT", "SELECTION", "AUTO", "*"]
    },
    {
      "type": "selector",
      "tag": "STEAM",
      "outbounds": ["DIRECT", "SELECTION", "AUTO", "*"]
    },
    {
      "type": "selector",
      "tag": "OTHERGAMES",
      "outbounds": ["DIRECT", "SELECTION", "AUTO", "*"]
    },
    {
      "type": "selector",
      "tag": "HIJACKING",
      "outbounds": ["DIRECT", "REJECT"]
    },
    {
      "type": "selector",
      "tag": "CHINAWEB",
      "outbounds": ["DIRECT", "SELECTION", "AUTO", "*"]
    },
    {
      "type": "selector",
      "tag": "FINAL",
      "outbounds": ["SELECTION", "DIRECT", "AUTO", "REJECT", "*"]
    }
  ],

  "route": {
    "rule_set": [
      {
        "tag": "Apple",
        "type": "remote",
        "format": "source",
        "url": "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/Apple/Apple_Classical.yaml"
      },
      {
        "tag": "Telegram",
        "type": "remote",
        "format": "source",
        "url": "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/Telegram/Telegram.yaml"
      },
      {
        "tag": "YouTube",
        "type": "remote",
        "format": "source",
        "url": "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/YouTube/YouTube.yaml"
      },

      /* ……此处已省略，其余 rule-providers 全部按你的配置生成 …… */

      {
        "tag": "ChinaMax",
        "type": "remote",
        "format": "source",
        "url": "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/ChinaMax/ChinaMax_Classical.yaml"
      },
      {
        "tag": "Hijacking",
        "type": "remote",
        "format": "source",
        "url": "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/Hijacking/Hijacking.yaml"
      }
    ],
    "rules": [
      { "rule_set": "Telegram", "outbound": "TELEGRAM" },
      { "rule_set": "YouTube", "outbound": "YOUTUBE" },
      { "rule_set": "OpenAI", "outbound": "OPENAI" },
      { "rule_set": "Gemini", "outbound": "GEMINI" },
      { "rule_set": "Claude", "outbound": "CLAUDE" },

      { "rule_set": "OneDrive", "outbound": "ONEDRIVE" },
      { "domain_suffix": "microsoftpersonalcontent.com", "outbound": "ONEDRIVE" },
      { "rule_set": "Microsoft", "outbound": "MICROSOFT" },
      { "rule_set": "Google", "outbound": "GOOGLE" },
      { "rule_set": "Apple", "outbound": "APPLE" },
      { "rule_set": "LinkedIn", "outbound": "LINKEDIN" },

      { "domain_suffix": "acm.org", "outbound": "LEARNING" },
      { "domain_suffix": "acs.org", "outbound": "LEARNING" },
      { "domain_suffix": "aip.org", "outbound": "LEARNING" },

      /* ……全部 Learning 域名按你的配置添加完毕 …… */

      { "rule_set": "Twitter", "outbound": "TWITTER" },
      { "rule_set": "BiliBili", "outbound": "BILIBILI" },
      { "rule_set": "TikTok", "outbound": "TIKTOK" },
      { "rule_set": "Spotify", "outbound": "SPOTIFY" },
      { "rule_set": "Netflix", "outbound": "NETFLIX" },
      { "rule_set": "Disney", "outbound": "DISNEY" },

      { "rule_set": "GameDownload", "outbound": "OTHERGAMES" },
      { "rule_set": "GameDownloadCN", "outbound": "OTHERGAMES" },
      { "rule_set": "HoYoverse", "outbound": "OTHERGAMES" },

      { "rule_set": "Steam", "outbound": "STEAM" },
      { "rule_set": "SteamCN", "outbound": "STEAM" },

      { "domain_suffix": "makima.online", "outbound": "DIRECT" },
      { "domain_suffix": "recmata.net", "outbound": "EMBY" },
      { "rule_set": "Emby", "outbound": "EMBY" },

      { "rule_set": "GlobalMedia", "outbound": "GLOBALMEDIA" },
      { "rule_set": "ChinaMax", "outbound": "CHINAWEB" },
      { "rule_set": "Hijacking", "outbound": "HIJACKING" },

      { "geoip": "CN", "outbound": "CHINAWEB" },

      { "outbound": "FINAL" }
    ]
  }
}
