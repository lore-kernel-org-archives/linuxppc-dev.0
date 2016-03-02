Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F0C71A029C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 12:36:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Add powerpc drivers to the powerpc section
Date: Wed,  2 Mar 2016 12:36:56 +1100
Message-Id: <1456882616-26811-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We'd like folks working on drivers for powerpc to also Cc linuxppc-dev,
so we can be aware of what's going on in drivers and/or review the
changes.

So add patterns to the powerpc MAINTAINERS section to catch some of the
drivers we're interested in.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

If I've missed some let me know.

diff --git a/MAINTAINERS b/MAINTAINERS
index 74bbff3dda52..671c87d40c03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6491,6 +6491,18 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 S:	Supported
 F:	Documentation/powerpc/
 F:	arch/powerpc/
+F:	drivers/char/tpm/tpm_ibmvtpm*
+F:	drivers/crypto/nx/
+F:	drivers/crypto/vmx/
+F:	drivers/net/ethernet/ibm/ibmveth.*
+F:	drivers/net/ethernet/ibm/ibmvnic.*
+F:	drivers/pci/hotplug/rpa*
+F:	drivers/scsi/ibmvscsi/
+N:	/pmac
+N:	powermac
+N:	powernv
+N:	[^a-z0-9]ps3
+N:	pseries
 
 LINUX FOR POWER MACINTOSH
 M:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
-- 
2.5.0
