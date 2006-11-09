Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2ACBA67C65
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Nov 2006 14:53:03 +1100 (EST)
Message-Id: <200611090352.kA93quLV003810@shell0.pdx.osdl.net>
Subject: [patch 1/3] ppc: booke reg MCSR msg misquoted
To: paulus@samba.org
From: akpm@osdl.org
Date: Wed, 08 Nov 2006 19:52:56 -0800
Cc: akpm@osdl.org, nkalmala@gmail.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

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
