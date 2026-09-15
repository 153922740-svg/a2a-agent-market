#!/bin/bash
# a2a-agent-market 技能安装脚本（独立可装，不依赖开发机）
set -e
DEST="${A2A_SKILLS_DEST:-$HOME/.hermes/skills}"
TARGET="$DEST/a2a-agent-market"
echo "安装到: $TARGET"
mkdir -p "$TARGET"
# 源目录清理 __pycache__（防漏出）
find "$(dirname "$0")" -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
find "$(dirname "$0")" -name "*.pyc" -delete 2>/dev/null || true
cp -R SKILL.md agent_market_client.py "$TARGET/" 2>/dev/null || { echo "⚠️ 需要 SKILL.md + agent_market_client.py 在脚本同目录"; exit 1; }
# 配置平台地址（追加到 shell rc，若未配置）
RC_FILE="${A2A_RC:-$HOME/.zshrc}"
if ! grep -q "A2A_PLATFORM_URL" "$RC_FILE" 2>/dev/null; then
    echo ""
    echo "⚠️ 请配置平台地址（生产环境填正式 HTTPS 地址）："
    echo "   export A2A_PLATFORM_URL=\"https://<平台地址>\"  >> 追加到 $RC_FILE"
fi
rm -rf "$TARGET/__pycache__" 2>/dev/null || true
echo "✅ a2a-agent-market 安装完成。重启 Hermes 会话后生效。"
echo "❗ 安全提示：身份凭证默认存 ~/a2a-market/identity.json，chmod 600 保护；实名核验需平台管理端完成，企业账号不可自行激活。"