Return-Path: <joe@perches.com>
Received: from perches.com (DSL022.labridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id 075C2DDEDC
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 16:31:23 +1000 (EST)
Date: Sun, 12 Aug 2007 23:31:07 -0700
From: joe@perches.com
To: torvalds@linux-foundation.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
	akpm@linux-foundation.org
Subject: [PATCH] [290/2many] MAINTAINERS - LINUX FOR POWER MACINTOSH
Message-ID: <46bffaab.+AAMCKKz1NEHjs/c%joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d1da70..8282088 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2784,6 +2784,8 @@ M:	benh@kernel.crashing.org
 W:	http://www.penguinppc.org/
 L:	linuxppc-dev@ozlabs.org
 S:	Maintained
+F:	arch/powerpc/platforms/powermac
+F:	include/asm-powerpc/pmac_*
 
 LINUX FOR POWERPC EMBEDDED MPC52XX
 P:	Sylvain Munaut
