Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 81D8767B5B
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 22:31:57 +1100 (EST)
Received: from pademelon.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id AF81F58ABD
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 12:31:53 +0100 (MET)
Date: Tue, 28 Nov 2006 12:31:53 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Clean images in arch/powerpc/boot
Message-ID: <Pine.LNX.4.62.0611281230590.15543@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Add a rule to clean up the various generated image files in arch/powerpc/boot/

Signed-Off-By: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

---
 arch/powerpc/boot/Makefile |    1 +
 1 files changed, 1 insertion(+)

--- ps3-linux-src.orig/arch/powerpc/boot/Makefile
+++ ps3-linux-src/arch/powerpc/boot/Makefile
@@ -181,3 +181,4 @@ install: $(CONFIGURE) $(image-y)
 
 clean-files += $(addprefix $(objtree)/, $(obj-boot) vmlinux.strip.gz)
 clean-files += $(addprefix $(objtree)/, $(obj-boot) vmlinux.bin.gz)
+clean-files += $(image-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
