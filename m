Return-Path: <galak@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id F1E6E67A65
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 02:39:38 +1100 (EST)
Date: Mon, 21 Mar 2005 09:39:12 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <34e690a54bb55ad44bb2518e1d7bf4f3@freescale.com>
Message-ID: <Pine.LNX.4.61.0503210937280.27668@blarg.somerset.sps.mot.com>
References: <34e690a54bb55ad44bb2518e1d7bf4f3@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	Segher Boessenkool <segher@kernel.crashing.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: typo fix in load/store string emulation
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrew,

Patch fixes a typo in the emulation of load/store string emulations 
pointed out by Segher Boessenkool.


Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/arch/ppc/kernel/traps.c b/arch/ppc/kernel/traps.c
--- a/arch/ppc/kernel/traps.c	2005-03-21 09:36:28 -06:00
+++ b/arch/ppc/kernel/traps.c	2005-03-21 09:36:28 -06:00
@@ -412,7 +412,7 @@
 			return -EINVAL;
 
 	/* Early out if we are an invalid form of lswi */
-	if ((instword & INST_STRING_MASK) == INST_LSWX)
+	if ((instword & INST_STRING_MASK) == INST_LSWI)
 		if ((rA >= rT) || (rT == rA))
 			return -EINVAL;
 
