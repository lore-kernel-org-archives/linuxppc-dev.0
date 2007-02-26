Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Mon, 26 Feb 2007 18:14:06 +0900
Subject: [PATCH] Add missing newline in xmon help output
Message-Id: <20070226091409.3DA95DDECD@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

My patch to add spu disassembly (af89fb8041562508895c8f3ba04790d7c2f4338c)
removed a newline from the xmon help that it shouldn't have, put it back.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
Paulus,
This is obviously fairly unimportant, but would be nice to have in
2.6.21 and shouldn't break anything .. touch wood.

---
 arch/powerpc/xmon/xmon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: powerpc/arch/powerpc/xmon/xmon.c
===================================================================
--- powerpc.orig/arch/powerpc/xmon/xmon.c
+++ powerpc/arch/powerpc/xmon/xmon.c
@@ -218,7 +218,7 @@ Commands:\n\
 "  ss	stop execution on all spus\n\
   sr	restore execution on stopped spus\n\
   sf  #	dump spu fields for spu # (in hex)\n\
-  sd  #	dump spu local store for spu # (in hex)\
+  sd  #	dump spu local store for spu # (in hex)\n\
   sdi #	disassemble spu local store for spu # (in hex)\n"
 #endif
 "  S	print special registers\n\
