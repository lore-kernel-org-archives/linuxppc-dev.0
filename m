Return-Path: <r66093@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 64ABDB7043
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2012 11:57:40 +1000 (EST)
Received: from mail223-ch1 (localhost [127.0.0.1])	by
 mail223-ch1-R.bigfish.com (Postfix) with ESMTP id D3D8E460462	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2012 01:57:34 +0000 (UTC)
Received: from CH1EHSMHS025.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.253])	by mail223-ch1.bigfish.com (Postfix) with ESMTP id
 B229C440073	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2012 01:57:32
 +0000 (UTC)
From: <Chang-Ming.Huang@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2] powerpc/p1022ds/DTS: Add RTC support
Date: Tue, 17 Apr 2012 09:42:35 +0800
Message-ID: <1334626955-8069-2-git-send-email-Chang-Ming.Huang@freescale.com>
In-Reply-To: <1334626955-8069-1-git-send-email-Chang-Ming.Huang@freescale.com>
References: <1334626955-8069-1-git-send-email-Chang-Ming.Huang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

Add the RTC support for p1022ds

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
---
 arch/powerpc/boot/dts/p1022ds.dtsi |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1022ds.dtsi b/arch/powerpc/boot/dts/p1022ds.dtsi
index 2b0d9e9..904b653 100644
--- a/arch/powerpc/boot/dts/p1022ds.dtsi
+++ b/arch/powerpc/boot/dts/p1022ds.dtsi
@@ -42,6 +42,10 @@
 			 * the clock is enabled.
 			 */
 		};
+		rtc@68 {
+			compatible = "dallas,ds1339";
+			reg = <0x68>;
+		};
 	};
 
 	spi@7000 {
-- 
1.7.5.4
