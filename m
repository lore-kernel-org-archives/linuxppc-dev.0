Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spkM66vRDzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 16:08:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] MAINTAINERS: Update powerpc website & add selftests
Date: Wed,  5 Oct 2016 16:08:16 +1100
Message-Id: <1475644096-16227-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The selftests under tools/testing/selftests/powerpc are maintained by
us, so add a file pattern for them.

Also drop the www.penguinppc.org link, it's not dead, but the site is
dead (database error). Instead link to the wiki attached to our github,
there is some info there which may be useful, which is better than none.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e3cfae014209..b27a26b16740 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7033,7 +7033,7 @@ LINUX FOR POWERPC (32-BIT AND 64-BIT)
 M:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
 M:	Paul Mackerras <paulus@samba.org>
 M:	Michael Ellerman <mpe@ellerman.id.au>
-W:	http://www.penguinppc.org/
+W:	https://github.com/linuxppc/linux/wiki
 L:	linuxppc-dev@lists.ozlabs.org
 Q:	http://patchwork.ozlabs.org/project/linuxppc-dev/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
@@ -7048,6 +7048,7 @@ F:	drivers/net/ethernet/ibm/ibmvnic.*
 F:	drivers/pci/hotplug/pnv_php.c
 F:	drivers/pci/hotplug/rpa*
 F:	drivers/scsi/ibmvscsi/
+F:	tools/testing/selftests/powerpc
 N:	opal
 N:	/pmac
 N:	powermac
-- 
2.7.4
