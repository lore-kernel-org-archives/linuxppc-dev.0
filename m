Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spkGG0S4bzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 16:04:06 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: paulus@samba.org
Subject: [PATCH] MAINTAINERS: Drop separate pseries entry
Date: Wed,  5 Oct 2016 16:04:00 +1100
Message-Id: <1475643840-14169-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul is no longer acting as a separate maintainer for pseries, it is
handled along with the rest of powerpc. The URL no longer links anywhere
meaningful, so drop it also.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 MAINTAINERS | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f593300e310b..e3cfae014209 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7029,12 +7029,6 @@ F:	drivers/lightnvm/
 F:	include/linux/lightnvm.h
 F:	include/uapi/linux/lightnvm.h
 
-LINUX FOR IBM pSERIES (RS/6000)
-M:	Paul Mackerras <paulus@au.ibm.com>
-W:	http://www.ibm.com/linux/ltc/projects/ppc
-S:	Supported
-F:	arch/powerpc/boot/rs6000.h
-
 LINUX FOR POWERPC (32-BIT AND 64-BIT)
 M:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
 M:	Paul Mackerras <paulus@samba.org>
-- 
2.7.4
