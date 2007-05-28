Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 09D81DDF07
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 10:20:44 +1000 (EST)
Date: Mon, 28 May 2007 10:20:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] pasemi idle uses hard_smp_processor_id
Message-Id: <20070528102045.5fb60480.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Olof Johansson <olof@lixom.net>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

and so needs to include asm/smp.h so a UP build works.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/pasemi/idle.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/arch/powerpc/platforms/pasemi/idle.c b/arch/powerpc/platforms/pasemi/idle.c
index 03cd45d..3c962d5 100644
--- a/arch/powerpc/platforms/pasemi/idle.c
+++ b/arch/powerpc/platforms/pasemi/idle.c
@@ -26,6 +26,7 @@
 
 #include <asm/machdep.h>
 #include <asm/reg.h>
+#include <asm/smp.h>
 
 #include "pasemi.h"
 
-- 
1.5.1.4
