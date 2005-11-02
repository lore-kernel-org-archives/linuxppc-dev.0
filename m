Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 347E96867B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Nov 2005 06:50:38 +1100 (EST)
Date: Wed, 2 Nov 2005 12:44:16 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051102144416.GE2609@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32 8xx: export symbols required for modular IDE
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


diff-tree 6ace3f3688d39df333975c0a1257f6364975b75f (from eea4169e9343e5e464355a442eca5c5cd6f3485e)
Author: Marcelo Tosatti <marcelo@pegasos.cnet>
Date:   Tue Oct 25 17:12:43 2005 -0500

    ppc32 8xx: export symbols required for modular IDE
    
      Building modules, stage 2.
      MODPOST
    *** Warning: "__ide_mm_insl" [drivers/ide/ide-core.ko] undefined!
    *** Warning: "__ide_mm_outsw" [drivers/ide/ide-core.ko] undefined!
    *** Warning: "__ide_mm_insw" [drivers/ide/ide-core.ko] undefined!
    *** Warning: "__ide_mm_outsl" [drivers/ide/ide-core.ko] undefined!

diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
index 2ccb58f..5152db8 100644
--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -136,6 +136,11 @@ EXPORT_SYMBOL(outw);
 EXPORT_SYMBOL(outl);
 EXPORT_SYMBOL(outsl);*/
 
+EXPORT_SYMBOL(__ide_mm_insl);
+EXPORT_SYMBOL(__ide_mm_outsw);
+EXPORT_SYMBOL(__ide_mm_insw);
+EXPORT_SYMBOL(__ide_mm_outsl);
+
 EXPORT_SYMBOL(_insb);
 EXPORT_SYMBOL(_outsb);
 EXPORT_SYMBOL(_insw);
