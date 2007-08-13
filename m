Return-Path: <joe@perches.com>
Received: from perches.com (DSL022.labridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id 01249DDF68
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Aug 2007 18:29:56 +1000 (EST)
Date: Sun, 12 Aug 2007 23:31:11 -0700
From: joe@perches.com
To: torvalds@linux-foundation.org, mporter@kernel.crashing.org,
	linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH] [292/2many] MAINTAINERS - LINUX FOR POWERPC EMBEDDED
 PPC4XX
Message-ID: <46bffaaf.2ObqORfh5YL/9ILj%joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 0862965..38810b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2804,6 +2804,8 @@ M:	mporter@kernel.crashing.org
 W:	http://www.penguinppc.org/
 L:	linuxppc-embedded@ozlabs.org
 S:	Maintained
+F:	arch/ppc/syslib/ppc4xx_*
+F:	include/asm-ppc/ppc4xx_*
 
 LINUX FOR POWERPC BOOT CODE
 P:	Tom Rini
