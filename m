Return-Path: <arnd@arndb.de>
Message-Id: <20060619183406.465452000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
Date: Mon, 19 Jun 2006 20:33:32 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 17/20] spufs: fix Makefile for "make clean"
Cc: Masato Noguchi <Masato.Noguchi@jp.sony.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Masato Noguchi <Masato.Noguchi@jp.sony.com>

added spu_{save,restore}_dump.h to target of 'make clean'

Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
 arch/powerpc/platforms/cell/spufs/Makefile |    1 +
 1 files changed, 1 insertion(+)

Index: powerpc.git/arch/powerpc/platforms/cell/spufs/Makefile
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spufs/Makefile
+++ powerpc.git/arch/powerpc/platforms/cell/spufs/Makefile
@@ -15,6 +15,7 @@ SPU_AFLAGS	:= -c -D__ASSEMBLY__ -I$(srct
 SPU_LDFLAGS	:= -N -Ttext=0x0
 
 $(obj)/switch.o: $(obj)/spu_save_dump.h $(obj)/spu_restore_dump.h
+clean-files := spu_save_dump.h spu_restore_dump.h
 
 # Compile SPU files
       cmd_spu_cc = $(SPU_CC) $(SPU_CFLAGS) -c -o $@ $<

--
