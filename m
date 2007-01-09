Return-Path: <paul.gortmaker@windriver.com>
Received: from yow-pgortmak-d1.corp.ad.wrs.com (unknown [67.71.254.34])
	by ozlabs.org (Postfix) with ESMTP id B1DEDDDE37
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 09:12:38 +1100 (EST)
Date: Tue, 9 Jan 2007 16:50:10 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: select DEFAULT_UIMAGE for HPC-NET/8641
Message-ID: <20070109215009.GB26654@windriver.com>
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

I suspect this was meant to be added like it was to a whole slew of
other u-boot based boards, but probably just fell through the cracks.

Add "select DEFAULT_UIMAGE" for the 8641/HPC-NET.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---


--- linux-2.6.20rc4/arch/powerpc/platforms/86xx/Kconfig.orig	2006-11-29 16:57:37.000000000 -0500
+++ linux-2.6.20rc4/arch/powerpc/platforms/86xx/Kconfig	2007-01-09 16:16:14.000000000 -0500
@@ -8,6 +8,7 @@ choice
 config MPC8641_HPCN
 	bool "Freescale MPC8641 HPCN"
 	select PPC_I8259
+	select DEFAULT_UIMAGE
 	help
 	  This option enables support for the MPC8641 HPCN board.
 
