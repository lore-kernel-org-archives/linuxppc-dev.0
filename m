Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 9DE04DDE20
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 16:21:52 +1100 (EST)
Date: Thu, 13 Mar 2008 16:20:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] really export empty_zero_page
Message-Id: <20080313162031.4a4a451a.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org,
	Theodore Tso <tytso@MIT.EDU>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It was being protected by CONFIG_PPC32.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/ppc_ksyms.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

I have applied this to today's linux-next tree.

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 9c98424..a722ede 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -58,7 +58,6 @@ extern void program_check_exception(struct pt_regs *regs);
 extern void single_step_exception(struct pt_regs *regs);
 extern int sys_sigreturn(struct pt_regs *regs);
 
-EXPORT_SYMBOL(empty_zero_page);
 EXPORT_SYMBOL(clear_pages);
 EXPORT_SYMBOL(copy_page);
 EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
@@ -192,3 +191,4 @@ EXPORT_SYMBOL(intercept_table);
 EXPORT_SYMBOL(__mtdcr);
 EXPORT_SYMBOL(__mfdcr);
 #endif
+EXPORT_SYMBOL(empty_zero_page);
-- 
1.5.4.3

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
