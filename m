Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wLln4DGtzF2R6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 18:47:49 +1000 (AEST)
Subject: Patch "net/ethernet/freescale/fman: fix cross-build error" has been
 added to the 4.4-stable tree
To: alexander.levin@microsoft.com, davem@davemloft.net,
 gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org,
 madalin.bucur@nxp.com, rdunlap@infradead.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 22 Aug 2018 10:37:32 +0200
Message-ID: <1534927052135133@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

    net/ethernet/freescale/fman: fix cross-build error

to the 4.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     net-ethernet-freescale-fman-fix-cross-build-error.patch
and it can be found in the queue-4.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo@baz Wed Aug 22 10:28:26 CEST 2018
From: Randy Dunlap <rdunlap@infradead.org>
Date: Fri, 13 Jul 2018 21:25:19 -0700
Subject: net/ethernet/freescale/fman: fix cross-build error

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit c133459765fae249ba482f62e12f987aec4376f0 ]

  CC [M]  drivers/net/ethernet/freescale/fman/fman.o
In file included from ../drivers/net/ethernet/freescale/fman/fman.c:35:
../include/linux/fsl/guts.h: In function 'guts_set_dmacr':
../include/linux/fsl/guts.h:165:2: error: implicit declaration of function 'clrsetbits_be32' [-Werror=implicit-function-declaration]
  clrsetbits_be32(&guts->dmacr, 3 << shift, device << shift);
  ^~~~~~~~~~~~~~~

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Madalin Bucur <madalin.bucur@nxp.com>
Cc: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/fsl/guts.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/linux/fsl/guts.h
+++ b/include/linux/fsl/guts.h
@@ -16,6 +16,7 @@
 #define __FSL_GUTS_H__
 
 #include <linux/types.h>
+#include <linux/io.h>
 
 /**
  * Global Utility Registers.


Patches currently in stable-queue which might be from rdunlap@infradead.org are

queue-4.4/tcp-identify-cryptic-messages-as-tcp-seq-bugs.patch
queue-4.4/net-ethernet-freescale-fman-fix-cross-build-error.patch
