Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E467CDDFD5
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 12:00:51 +1000 (EST)
Date: Mon, 14 Apr 2008 12:00:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] [POWERPC] remove include of asm/of_device.h from pmi.h
Message-Id: <20080414120047.8144976b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

pmi.h does not diectly reference anything in of_device.h and of the two
files that include asm/pmi.h, one includes of_device.h and the other
includes of_platform.h (which includes of_device.h).

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-powerpc/pmi.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/asm-powerpc/pmi.h b/include/asm-powerpc/pmi.h
index 2259d4c..e1dc090 100644
--- a/include/asm-powerpc/pmi.h
+++ b/include/asm-powerpc/pmi.h
@@ -29,8 +29,6 @@
 
 #ifdef __KERNEL__
 
-#include <asm/of_device.h>
-
 #define PMI_TYPE_FREQ_CHANGE	0x01
 #define PMI_READ_TYPE		0
 #define PMI_READ_DATA0		1
-- 
1.5.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
