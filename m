Return-Path: <joe@perches.com>
Received: from perches.com (DSL022.labridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id 83599DDEE1
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 16:31:19 +1000 (EST)
Date: Sun, 12 Aug 2007 23:31:05 -0700
From: joe@perches.com
To: torvalds@linux-foundation.org, paulus@samba.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: [PATCH] [289/2many] MAINTAINERS - LINUX FOR POWERPC
Message-ID: <46bffaa9.Up0nOpoPeVCIyvqc%joe@perches.com>
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
index c643ebe..1d1da70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2775,6 +2775,8 @@ W:	http://www.penguinppc.org/
 L:	linuxppc-dev@ozlabs.org
 T:	git kernel.org:/pub/scm/linux/kernel/git/paulus/powerpc.git
 S:	Supported
+F:	arch/powerpc
+F:	include/asm-powerpc/
 
 LINUX FOR POWER MACINTOSH
 P:	Benjamin Herrenschmidt
