Return-Path: <joe@perches.com>
Received: from perches.com (DSL022.labridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id AFDBEDDEE4
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Aug 2007 16:33:30 +1000 (EST)
Date: Sun, 12 Aug 2007 23:27:51 -0700
From: joe@perches.com
To: torvalds@linux-foundation.org, netdev@vger.kernel.org,
	linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org,
	leoli@freescale.com, akpm@linux-foundation.org
Subject: [PATCH] [195/2many] MAINTAINERS - FREESCALE QUICC ENGINE UCC
	ETHERNET DRIVER
Message-ID: <46bff9e7.He8/+5xXuJGrnQHg%joe@perches.com>
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
index 944316a..35f1636 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1876,6 +1876,7 @@ M:	leoli@freescale.com
 L:	netdev@vger.kernel.org
 L:	linuxppc-embedded@ozlabs.org
 S:	Maintained
+F:	drivers/net/ucc_geth*
 
 FILE LOCKING (flock() and fcntl()/lockf())
 P:	Matthew Wilcox
