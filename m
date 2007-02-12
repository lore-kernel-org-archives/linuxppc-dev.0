Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id EB3ABDDE0C
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 22:10:16 +1100 (EST)
Date: Mon, 12 Feb 2007 22:10:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] correct a prototype
Message-Id: <20070212221048.cb5fcc07.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This rids us of a warning.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/cputable.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index dd17dff..7ec4ac7 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -44,7 +44,7 @@ extern void __setup_cpu_745x(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_ppc970(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_ppc970MP(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_pa6t(unsigned long offset, struct cpu_spec* spec);
-extern void __restore_cpu_pa6t(unsigned long offset, struct cpu_spec* spec);
+extern void __restore_cpu_pa6t(void);
 extern void __restore_cpu_ppc970(void);
 #endif /* CONFIG_PPC64 */
 
-- 
1.4.4.4
