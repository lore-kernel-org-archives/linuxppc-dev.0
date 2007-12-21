Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EABFFDDE24
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 03:25:06 +1100 (EST)
Date: Fri, 21 Dec 2007 19:22:23 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4] PowerPC: Correct 440GRx machine_check callback
Message-ID: <20071221162223.GA1645@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071221160723.GA1430@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Correct the PowerPC 440GRx machine check callback.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/kernel/cputable.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -pruN linux-2.6.orig/arch/powerpc/kernel/cputable.c linux-2.6/arch/powerpc/kernel/cputable.c
--- linux-2.6.orig/arch/powerpc/kernel/cputable.c	2007-12-21 17:14:17.000000000 +0300
+++ linux-2.6/arch/powerpc/kernel/cputable.c	2007-12-21 18:05:08.000000000 +0300
@@ -1247,7 +1247,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440grx,
-		.machine_check		= machine_check_4xx,
+		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
 	{ /* Use logical PVR for 440EPx (logical pvr = pvr | 0x8) */
