Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 501FBDE44C
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Dec 2006 02:12:01 +1100 (EST)
Date: Wed, 20 Dec 2006 16:11:57 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] PS3: Fix uniprocessor kernel build
Message-ID: <Pine.LNX.4.62.0612201611100.11585@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Allow to build a uniprocessor kernel for PS3

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 arch/powerpc/platforms/ps3/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- ps3-linux-src.orig/arch/powerpc/platforms/ps3/Makefile
+++ ps3-linux-src/arch/powerpc/platforms/ps3/Makefile
@@ -1,4 +1,5 @@
-obj-y += setup.o mm.o smp.o time.o hvcall.o htab.o repository.o
+obj-y += setup.o mm.o time.o hvcall.o htab.o repository.o
 obj-y += interrupt.o exports.o os-area.o
 
+obj-$(CONFIG_SMP) += smp.o
 obj-$(CONFIG_SPU_BASE) += spu.o

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
