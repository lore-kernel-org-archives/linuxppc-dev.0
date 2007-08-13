Return-Path: <joe@perches.com>
Received: from perches.com (DSL022.labridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id 527DDDDED9
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 16:31:26 +1000 (EST)
Date: Sun, 12 Aug 2007 23:31:09 -0700
From: joe@perches.com
To: torvalds@linux-foundation.org, tnt@246tNt.com,
	linuxppc-embedded@ozlabs.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: [PATCH] [291/2many] MAINTAINERS - LINUX FOR POWERPC EMBEDDED MPC52XX
Message-ID: <46bffaad.AUgmjGFlO0xv860X%joe@perches.com>
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
index 8282088..0862965 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2795,6 +2795,8 @@ W:	http://www.penguinppc.org/
 L:	linuxppc-dev@ozlabs.org
 L:	linuxppc-embedded@ozlabs.org
 S:	Maintained
+F:	arch/powerpc/platforms/52xx/
+F:	include/asm-powerpc/mpc52xx.h
 
 LINUX FOR POWERPC EMBEDDED PPC4XX
 P:	Matt Porter
