Return-Path: <mathieu.desnoyers@polymtl.ca>
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.polymtl.ca", Issuer "Ca_Cert_Smtp_Poly" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0EAC1DE4F2
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 03:50:17 +1000 (EST)
Message-Id: <20080422172842.427209743@polymtl.ca>
References: <20080422172404.502954084@polymtl.ca>
Date: Tue, 22 Apr 2008 13:24:10 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Sam Ravnborg <sam@ravnborg.org>, akpm@linux-foundation.org,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: [RFC patch 6/9] POWERPC remove -traditional
Cc: paulus@samba.org, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Subject: [RFC patch 6/9] Re: [PATCH] Stringify support commas
 > This is a no-no for those archs that still use -traditional.
 > > I dunno if this is a problem for you at the moment and the
 > > right fix is anyway to nuke -traditional.
 > > 
 > >     Sam

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: Sam Ravnborg <sam@ravnborg.org>
CC: paulus@samba.org
CC: linuxppc-dev@ozlabs.org
---
 arch/powerpc/boot/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-lttng/arch/powerpc/boot/Makefile
===================================================================
--- linux-2.6-lttng.orig/arch/powerpc/boot/Makefile	2008-04-21 10:03:05.000000000 -0400
+++ linux-2.6-lttng/arch/powerpc/boot/Makefile	2008-04-21 10:03:17.000000000 -0400
@@ -23,7 +23,7 @@ BOOTCFLAGS    := -Wall -Wundef -Wstrict-
 		 -fno-strict-aliasing -Os -msoft-float -pipe \
 		 -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
 		 -isystem $(shell $(CROSS32CC) -print-file-name=include)
-BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
+BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -nostdinc
 
 ifdef CONFIG_DEBUG_INFO
 BOOTCFLAGS	+= -g

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
