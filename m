Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ey0-f177.google.com (mail-ey0-f177.google.com
	[209.85.215.177]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D9746B6F86
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 18:54:58 +1000 (EST)
Received: by mail-ey0-f177.google.com with SMTP id 6so2714299eyh.36
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 01:54:58 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 08/14] 85xx/sbc8560: declare that localbus is compatbile with
	simple-bus
Date: Tue, 19 Jul 2011 12:53:45 +0400
Message-Id: <1311065631-3429-9-git-send-email-dbaryshkov@gmail.com>
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
 arch/powerpc/boot/dts/sbc8560.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/sbc8560.dts b/arch/powerpc/boot/dts/sbc8560.dts
index 9e13ed8..72078eb 100644
--- a/arch/powerpc/boot/dts/sbc8560.dts
+++ b/arch/powerpc/boot/dts/sbc8560.dts
@@ -331,7 +331,7 @@
 	};
 
 	localbus@ff705000 {
-		compatible = "fsl,mpc8560-localbus";
+		compatible = "fsl,mpc8560-localbus", "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <1>;
 		reg = <0xff705000 0x100>;	// BRx, ORx, etc.
-- 
1.7.2.5
