Return-Path: <galak@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C827A67A66
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Jun 2005 00:14:49 +1000 (EST)
Date: Sun, 26 Jun 2005 09:14:45 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0506260914060.9741@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Fix compiling of sandpoint platform
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Lost a curly brace in translation.  Everything is better now.

Signed-off-by: Matt McClintock <msm@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit fa74c2ff204f054a538f709b0b7ead0051554967
tree 7a5ce7b9f36499969eeb246331e0e0ad85178a20
parent 9316e99785fbb5da61e7a14c8bdaf5e08d3b9d72
author Kumar K. Gala <kumar.gala@freescale.com> Sun, 26 Jun 2005 10:46:40 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Sun, 26 Jun 2005 10:46:40 -0500

 arch/ppc/platforms/sandpoint.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/platforms/sandpoint.c b/arch/ppc/platforms/sandpoint.c
--- a/arch/ppc/platforms/sandpoint.c
+++ b/arch/ppc/platforms/sandpoint.c
@@ -324,6 +324,7 @@ sandpoint_setup_arch(void)
 			pdata[1].irq = 0;
 			pdata[1].mapbase = 0;
 		}
+	}
 
 	printk(KERN_INFO "Motorola SPS Sandpoint Test Platform\n");
 	printk(KERN_INFO "Port by MontaVista Software, Inc. (source@mvista.com)\n");
