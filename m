Return-Path: <asmirnov@ru.mvista.com>
Received: from spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26211DE209
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 05:36:33 +1100 (EST)
Received: from spb.rtsoft.ru (spb.rtsoft.ru [127.0.0.1])
	by spb.rtsoft.ru (8.13.5/8.13.5) with ESMTP id m1SIicCp027253
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 21:44:38 +0300
Received: (from alex@localhost)
	by spb.rtsoft.ru (8.13.5/8.13.5/Submit) id m1SIicfW027252
	for linuxppc-dev@ozlabs.org; Thu, 28 Feb 2008 21:44:38 +0300
Date: Thu, 28 Feb 2008 21:44:38 +0300
From: Alexandr Smirnov <asmirnov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4] Emerson KSI8560 bootwrapper
Message-ID: <20080228184438.GB26971@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080228183503.GA26971@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index e3993a6..f43dd6e 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -255,6 +255,7 @@ image-$(CONFIG_TQM8555)			+= cuImage.tqm8555
 image-$(CONFIG_TQM8560)			+= cuImage.tqm8560
 image-$(CONFIG_SBC8548)			+= cuImage.tqm8548
 image-$(CONFIG_SBC8560)			+= cuImage.tqm8560
+image-$(CONFIG_KSI8560)			+= cuImage.ksi8560
 
 # Board ports in arch/powerpc/platform/embedded6xx/Kconfig
 image-$(CONFIG_STORCENTER)		+= cuImage.storcenter
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index c317815..6655a90 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -174,7 +174,7 @@ cuboot*)
     *-mpc83*)
         platformo=$object/cuboot-83xx.o
         ;;
-    *-tqm8541|*-mpc8560*|*-tqm8560|*-tqm8555*)
+    *-tqm8541|*-mpc8560*|*-tqm8560|*-tqm8555*|*-ksi8560*)
         platformo=$object/cuboot-85xx-cpm2.o
         ;;
     *-mpc85*)
