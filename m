Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 02CED1A1062
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 19:18:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] powerpc: Update MAINTAINERS to point at shared tree
Date: Tue,  7 Jul 2015 19:18:01 +1000
Message-Id: <1436260681-9684-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have a shared powerpc tree on kernel.org, point folks at that
as the primary place to look for powerpc stuff.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8133cefb6b6e..b29f8ebc10b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6161,7 +6161,7 @@ M:	Michael Ellerman <mpe@ellerman.id.au>
 W:	http://www.penguinppc.org/
 L:	linuxppc-dev@lists.ozlabs.org
 Q:	http://patchwork.ozlabs.org/project/linuxppc-dev/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 S:	Supported
 F:	Documentation/powerpc/
 F:	arch/powerpc/
-- 
2.1.0
