Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id 72235DDEDC
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Apr 2007 17:12:07 +1000 (EST)
Date: Mon, 16 Apr 2007 09:12:04 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] mpc5200: set efika's device_type to "soc"
Message-ID: <20070416071203.GJ18236@moe.telargo.com>
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

Device type should be "soc" (as in lite5200.dts), compatible is
already set to "mpc5200".


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
---
 arch/powerpc/kernel/prom_init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: grant.git/arch/powerpc/kernel/prom_init.c
===================================================================
--- grant.git.orig/arch/powerpc/kernel/prom_init.c
+++ grant.git/arch/powerpc/kernel/prom_init.c
@@ -2142,7 +2142,7 @@ static void __init fixup_device_tree_efi
 	                             3,12,0, 3,13,0, 3,14,0, 3,15,0 };
 	struct subst_entry efika_subst_table[] = {
 		{ "/",			"device_type",	prop_cstr("efika") },
-		{ "/builtin",		"compatible",	prop_cstr("soc") },
+		{ "/builtin",		"device_type",	prop_cstr("soc") },
 		{ "/builtin/ata",	"compatible",	prop_cstr("mpc5200b-ata\0mpc5200-ata"), },
 		{ "/builtin/bestcomm",	"compatible",	prop_cstr("mpc5200b-bestcomm\0mpc5200-bestcomm") },
 		{ "/builtin/bestcomm",	"interrupts",	prop_bcomm_irq, sizeof(prop_bcomm_irq) },
