Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.25])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2A8F867C4A
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 11:10:48 +1100 (EST)
Message-Id: <200611230010.kAN0AUi6020902@shell0.pdx.osdl.net>
Subject: - ppc-booke-reg-mcsr-msg-misquoted.patch removed from -mm tree
To: nkalmala@gmail.com, benh@kernel.crashing.org, galak@kernel.crashing.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, mm-commits@vger.kernel.org
From: akpm@osdl.org
Date: Wed, 22 Nov 2006 16:10:30 -0800
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The patch titled
     ppc: booke reg MCSR msg misquoted
has been removed from the -mm tree.  Its filename was
     ppc-booke-reg-mcsr-msg-misquoted.patch

This patch was dropped because it was merged into mainline or a subsystem tree

------------------------------------------------------
Subject: ppc: booke reg MCSR msg misquoted
From: nkalmala <nkalmala@gmail.com>

PPC/booke reg MCSR value misquoted

Signed-off-by: nkalmala <nkalmala@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@ozlabs.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc/kernel/traps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/ppc/kernel/traps.c~ppc-booke-reg-mcsr-msg-misquoted arch/ppc/kernel/traps.c
--- a/arch/ppc/kernel/traps.c~ppc-booke-reg-mcsr-msg-misquoted
+++ a/arch/ppc/kernel/traps.c
@@ -316,7 +316,7 @@ void machine_check_exception(struct pt_r
 	if (reason & MCSR_BUS_RBERR)
 		printk("Bus - Read Data Bus Error\n");
 	if (reason & MCSR_BUS_WBERR)
-		printk("Bus - Read Data Bus Error\n");
+		printk("Bus - Write Data Bus Error\n");
 	if (reason & MCSR_BUS_IPERR)
 		printk("Bus - Instruction Parity Error\n");
 	if (reason & MCSR_BUS_RPERR)
_

Patches currently in -mm which might be from nkalmala@gmail.com are

git-powerpc.patch
