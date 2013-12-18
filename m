Return-Path: <Dongsheng.Wang@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 663FE2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2013 19:42:15 +1100 (EST)
Received: from mail115-db9 (localhost [127.0.0.1])	by
 mail115-db9-R.bigfish.com (Postfix) with ESMTP id 01BAA26054C	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2013 08:42:09 +0000 (UTC)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>, <Chang-Ming.Huang@freescale.com>,
 <roy.zang@freescale.com>
Subject: [PATCH 1/2] powerpc/p1022ds: fix rtc compatible string
Date: Wed, 18 Dec 2013 16:39:23 +0800
Message-ID: <1387355964-39486-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

RTC Hardware(ds3232) and rtc compatible string does not match.
Change "dallas,ds1339" to "dallas,ds3232".

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/arch/powerpc/boot/dts/p1022ds.dtsi b/arch/powerpc/boot/dts/p1022ds.dtsi
index 873da35..5725058 100644
--- a/arch/powerpc/boot/dts/p1022ds.dtsi
+++ b/arch/powerpc/boot/dts/p1022ds.dtsi
@@ -146,7 +146,7 @@
 			 */
 		};
 		rtc@68 {
-			compatible = "dallas,ds1339";
+			compatible = "dallas,ds3232";
 			reg = <0x68>;
 		};
 		adt7461@4c {
-- 
1.8.5
