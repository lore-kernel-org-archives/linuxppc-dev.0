Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2192C1A0BDF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 15:17:36 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 13 Feb 2015 14:17:34 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2F3532CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 15:17:32 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1D4HMhT9044138
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 15:17:31 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1D4GvrY015689
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 15:16:57 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pci: Fix comments about ppc_md.pcibios_fixup
Date: Fri, 13 Feb 2015 15:16:32 +1100
Message-Id: <1423800992-3964-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch fixes the comments about ppc_md.pcibios_fixup(), which
should be called after allocating resources.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index c8175a3..098d51e 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -125,7 +125,7 @@ struct machdep_calls {
 	unsigned int	(*get_irq)(void);
 
 	/* PCI stuff */
-	/* Called after scanning the bus, before allocating resources */
+	/* Called after allocating resources */
 	void		(*pcibios_fixup)(void);
 	int		(*pci_probe_mode)(struct pci_bus *);
 	void		(*pci_irq_fixup)(struct pci_dev *dev);
-- 
1.8.3.2
