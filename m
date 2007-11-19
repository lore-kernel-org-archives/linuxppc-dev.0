Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A8295DDE25
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 17:16:59 +1100 (EST)
Date: Mon, 19 Nov 2007 17:17:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] remove redundant declaration of hose_list.
Message-Id: <20071119171707.f3cdc3f2.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It is already declared in ppc-pci.h which is included.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/pci-common.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 742ff72..15ec71a 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -50,8 +50,6 @@ static DEFINE_SPINLOCK(hose_spinlock);
 /* XXX kill that some day ... */
 static int global_phb_number;		/* Global phb counter */
 
-extern struct list_head hose_list;
-
 /*
  * pci_controller(phb) initialized common variables.
  */
-- 
1.5.3.5
