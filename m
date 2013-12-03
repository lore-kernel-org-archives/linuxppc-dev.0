Return-Path: <Chunhe.Lan@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4B87F2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Dec 2013 18:33:26 +1100 (EST)
Received: from mail164-va3 (localhost [127.0.0.1])	by
 mail164-va3-R.bigfish.com (Postfix) with ESMTP id D78583801E9	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Dec 2013 07:33:20 +0000 (UTC)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/defconfig: Enable ath9k wireless card support
Date: Tue, 3 Dec 2013 15:32:20 +0800
Message-ID: <1386055940-20629-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On the P1023RDB, when board leaves the factory, it has
two Atheros wireless cards on the PCIe slot. So enable
ath9k wireless driver support.

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/configs/85xx/p1023_defconfig |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/85xx/p1023_defconfig b/arch/powerpc/configs/85xx/p1023_defconfig
index b06d37d..a3fe941 100644
--- a/arch/powerpc/configs/85xx/p1023_defconfig
+++ b/arch/powerpc/configs/85xx/p1023_defconfig
@@ -62,6 +62,9 @@ CONFIG_INET_ESP=y
 # CONFIG_INET_LRO is not set
 CONFIG_IPV6=y
 CONFIG_IP_SCTP=m
+CONFIG_CFG80211=y
+CONFIG_CFG80211_WEXT=y
+CONFIG_MAC80211=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
@@ -101,6 +104,8 @@ CONFIG_DAVICOM_PHY=y
 CONFIG_CICADA_PHY=y
 CONFIG_VITESSE_PHY=y
 CONFIG_FIXED_PHY=y
+CONFIG_ATH_CARDS=y
+CONFIG_ATH9K=y
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
-- 
1.7.6.5
