Return-Path: <joe@perches.com>
Received: from perches.com (DSL022.labridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id 19E23DDED9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Aug 2007 16:33:33 +1000 (EST)
Date: Sun, 12 Aug 2007 23:27:48 -0700
From: joe@perches.com
To: torvalds@linux-foundation.org, linuxppc-embedded@ozlabs.org,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	leoli@freescale.com, akpm@linux-foundation.org
Subject: [PATCH] [194/2many] MAINTAINERS - FREESCALE HIGHSPEED USB DEVICE
	DRIVER
Message-ID: <46bff9e4.zwo/ub/ZnK6PrXO2%joe@perches.com>
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
index 2ef0ec4..944316a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1868,6 +1868,7 @@ M:	leoli@freescale.com
 L:	linux-usb-devel@lists.sourceforge.net
 L:	linuxppc-embedded@ozlabs.org
 S:	Maintained
+F:	drivers/usb/gadget/fsl_usb2_udc.c
 
 FREESCALE QUICC ENGINE UCC ETHERNET DRIVER
 P:	Li Yang
