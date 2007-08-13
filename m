Return-Path: <joe@perches.com>
Received: from perches.com (DSL022.labridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id C2501DDEDF
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Aug 2007 16:34:45 +1000 (EST)
Date: Sun, 12 Aug 2007 23:34:03 -0700
From: joe@perches.com
To: torvalds@linux-foundation.org, netdev@vger.kernel.org,
	linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org,
	ebs@ebshome.net, akpm@linux-foundation.org
Subject: [PATCH] [381/2many] MAINTAINERS - POWERPC 4xx EMAC DRIVER
Message-ID: <46bffb5b.SDKlqxp2iUQU9mxr%joe@perches.com>
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
index 0d30368..f526cf5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3659,6 +3659,7 @@ W:	http://kernel.ebshome.net/emac/
 L:	linuxppc-embedded@ozlabs.org
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	drivers/net/ibm_emac/
 
 PNP SUPPORT
 P:	Adam Belay
