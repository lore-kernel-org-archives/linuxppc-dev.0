Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A7EFAB7316
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 18:54:53 +1000 (EST)
Received: by ewy6 with SMTP id 6so1840111ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 01:54:49 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 03/14] mpc8349emitx: mark localbus as compatible with
	simple-bus
Date: Tue, 19 Jul 2011 12:53:40 +0400
Message-Id: <1311065631-3429-4-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/boot/dts/mpc8349emitx.dts |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index b53d1df..505dc84 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -390,7 +390,8 @@
 		#address-cells = <2>;
 		#size-cells = <1>;
 		compatible = "fsl,mpc8349e-localbus",
-			     "fsl,pq2pro-localbus";
+			     "fsl,pq2pro-localbus",
+			     "simple-bus";
 		reg = <0xe0005000 0xd8>;
 		ranges = <0x0 0x0 0xfe000000 0x1000000	/* flash */
 			  0x1 0x0 0xf8000000 0x20000	/* VSC 7385 */
-- 
1.7.2.5
