Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F01EE6867B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Nov 2005 06:50:40 +1100 (EST)
Date: Wed, 2 Nov 2005 12:42:16 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051102144215.GD2609@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32 8xx: fix cpm_dpalloc() comment
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Current comment on top of m8xx_cpm_dpinit is wrong.

Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

diff --git a/arch/ppc/8xx_io/commproc.c b/arch/ppc/8xx_io/commproc.c
index 18fa51c..4306deb 100644
--- a/arch/ppc/8xx_io/commproc.c
+++ b/arch/ppc/8xx_io/commproc.c
@@ -390,9 +390,8 @@ void m8xx_cpm_dpinit(void)
 
 /*
  * Allocate the requested size worth of DP memory.
- * This function used to return an index into the DPRAM area.
- * Now it returns the actuall physical address of that area.
- * use m8xx_cpm_dpram_offset() to get the index
+ * This function returns an offset into the DPRAM area.
+ * Use cpm_dpram_addr() to get the virtual address of the area.
  */
 uint cpm_dpalloc(uint size, uint align)
 {
