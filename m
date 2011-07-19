Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ey0-f177.google.com (mail-ey0-f177.google.com
	[209.85.215.177]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EBBC8B7497
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 18:55:00 +1000 (EST)
Received: by eyh6 with SMTP id 6so2714358eyh.36
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 01:54:56 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 07/14] 85xx/ksi8560: declare that localbus is compatbile with
	simple-bus
Date: Tue, 19 Jul 2011 12:53:44 +0400
Message-Id: <1311065631-3429-8-git-send-email-dbaryshkov@gmail.com>
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
 arch/powerpc/boot/dts/ksi8560.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/ksi8560.dts b/arch/powerpc/boot/dts/ksi8560.dts
index bdb7fc0..296c572 100644
--- a/arch/powerpc/boot/dts/ksi8560.dts
+++ b/arch/powerpc/boot/dts/ksi8560.dts
@@ -306,7 +306,7 @@
 	localbus@fdf05000 {
 		#address-cells = <2>;
 		#size-cells = <1>;
-		compatible = "fsl,mpc8560-localbus";
+		compatible = "fsl,mpc8560-localbus", "simple-bus";
 		reg = <0xfdf05000 0x68>;
 
 		ranges = <0x0 0x0 0xe0000000 0x00800000
-- 
1.7.2.5
