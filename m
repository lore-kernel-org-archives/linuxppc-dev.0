Return-Path: <joe@perches.com>
Received: from perches.com (DSL022.labridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id 91DD6DDF04
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Aug 2007 18:29:52 +1000 (EST)
Date: Sun, 12 Aug 2007 23:31:16 -0700
From: joe@perches.com
To: torvalds@linux-foundation.org, linuxppc-embedded@ozlabs.org,
	linux-kernel@vger.kernel.org, galak@kernel.crashing.org,
	akpm@linux-foundation.org
Subject: [PATCH] [295/2many] MAINTAINERS - LINUX FOR POWERPC EMBEDDED
	PPC83XX AND PPC85XX
Message-ID: <46bffab4.3GfGfPg42InTJWd+%joe@perches.com>
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
index 896c8bf..a289176 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2829,6 +2829,7 @@ M:	galak@kernel.crashing.org
 W:	http://www.penguinppc.org/
 L:	linuxppc-embedded@ozlabs.org
 S:	Maintained
+F:	arch/ppc/syslib/ppc83xx_*
 
 LINUX FOR POWERPC PA SEMI PWRFICIENT
 P:	Olof Johansson
