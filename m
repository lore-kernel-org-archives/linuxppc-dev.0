Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B207C2C0378
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 22:48:09 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 8 Mar 2013 04:48:06 -0700
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 6329019D8042
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 04:48:00 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r28Bm25c078976
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Mar 2013 04:48:02 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r28Bm1ZT029397
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Mar 2013 04:48:02 -0700
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/kernel: Cleanup on rtas_pci.c
Date: Fri,  8 Mar 2013 19:47:58 +0800
Message-Id: <1362743278-25729-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It's minor cleanup so that the function names comply with the
coding style.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/rtas_pci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index 81c1abb..8d26f92 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -202,7 +202,7 @@ static void python_countermeasures(struct device_node *dev)
 	iounmap(chip_regs);
 }
 
-void __init init_pci_config_tokens (void)
+void __init init_pci_config_tokens(void)
 {
 	read_pci_config = rtas_token("read-pci-config");
 	write_pci_config = rtas_token("write-pci-config");
@@ -210,7 +210,7 @@ void __init init_pci_config_tokens (void)
 	ibm_write_pci_config = rtas_token("ibm,write-pci-config");
 }
 
-unsigned long get_phb_buid (struct device_node *phb)
+unsigned long get_phb_buid(struct device_node *phb)
 {
 	struct resource r;
 
-- 
1.7.5.4
