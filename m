Return-Path: <joe@perches.com>
Received: from perches.com (DSL022.labridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id 796CEDDED9
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 16:31:33 +1000 (EST)
Date: Sun, 12 Aug 2007 23:31:18 -0700
From: joe@perches.com
To: torvalds@linux-foundation.org, olof@lixom.net, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: [PATCH] [296/2many] MAINTAINERS - LINUX FOR POWERPC PA SEMI PWRFICIENT
Message-ID: <46bffab6.9F8kfme4utaitNZV%joe@perches.com>
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
index a289176..6fdca8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2837,6 +2837,7 @@ M:	olof@lixom.net
 W:	http://www.pasemi.com/
 L:	linuxppc-dev@ozlabs.org
 S:	Supported
+F:	arch/powerpc/platforms/pasemi/
 
 LLC (802.2)
 P:	Arnaldo Carvalho de Melo
