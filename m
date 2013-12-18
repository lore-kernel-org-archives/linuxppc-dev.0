Return-Path: <Dongsheng.Wang@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C11952C0337
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2013 19:42:21 +1100 (EST)
Received: from mail44-db8 (localhost [127.0.0.1])	by mail44-db8-R.bigfish.com
 (Postfix) with ESMTP id E96D842076D	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 18 Dec 2013 08:42:15 +0000 (UTC)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>, <Chang-Ming.Huang@freescale.com>,
 <roy.zang@freescale.com>
Subject: [PATCH 2/2] powerpc/p1022ds: add a interrupt for rtc node
Date: Wed, 18 Dec 2013 16:39:24 +0800
Message-ID: <1387355964-39486-2-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1387355964-39486-1-git-send-email-dongsheng.wang@freescale.com>
References: <1387355964-39486-1-git-send-email-dongsheng.wang@freescale.com>
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

Add an external interrupt for rtc node.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/arch/powerpc/boot/dts/p1022ds.dtsi b/arch/powerpc/boot/dts/p1022ds.dtsi
index 5725058..957e0dc 100644
--- a/arch/powerpc/boot/dts/p1022ds.dtsi
+++ b/arch/powerpc/boot/dts/p1022ds.dtsi
@@ -148,6 +148,7 @@
 		rtc@68 {
 			compatible = "dallas,ds3232";
 			reg = <0x68>;
+			interrupts = <0x1 0x1 0 0>;
 		};
 		adt7461@4c {
 			compatible = "adi,adt7461";
-- 
1.8.5
