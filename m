Return-Path: <B25806@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3CB012C0084
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2012 17:54:54 +1000 (EST)
Received: from mail47-tx2 (localhost [127.0.0.1])	by mail47-tx2-R.bigfish.com
 (Postfix) with ESMTP id BBB9A4200F0	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,
 14 Sep 2012 07:54:49 +0000 (UTC)
Received: from TX2EHSMHS037.bigfish.com (unknown [10.9.14.242])	by
 mail47-tx2.bigfish.com (Postfix) with ESMTP id 9E8854C0047	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2012 07:54:47 +0000 (UTC)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] p1023rds_defconfig: Add USB support
Date: Fri, 14 Sep 2012 15:57:20 -0400
Message-ID: <1347652640-20748-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
---
 arch/powerpc/configs/85xx/p1023rds_defconfig |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/85xx/p1023rds_defconfig b/arch/powerpc/configs/85xx/p1023rds_defconfig
index 26e541c..b80bcc6 100644
--- a/arch/powerpc/configs/85xx/p1023rds_defconfig
+++ b/arch/powerpc/configs/85xx/p1023rds_defconfig
@@ -112,6 +112,12 @@ CONFIG_SND=y
 CONFIG_SND_MIXER_OSS=y
 CONFIG_SND_PCM_OSS=y
 # CONFIG_SND_SUPPORT_OLD_API is not set
+CONFIG_USB=y
+CONFIG_USB_DEVICEFS=y
+CONFIG_USB_MON=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_FSL=y
+CONFIG_USB_STORAGE=y
 CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_RTC_CLASS=y
-- 
1.7.6.5
