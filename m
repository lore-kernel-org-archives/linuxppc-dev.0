Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 565A71A0FA4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 17:36:33 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 5 Feb 2015 16:36:31 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1E731357804C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 17:36:30 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t156aLiD42795036
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Feb 2015 17:36:30 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t156Zu4Z014214
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Feb 2015 17:35:56 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH 3/3] remove the unused end in pnv_pci_vf_resource_shift()
Date: Thu,  5 Feb 2015 14:34:25 +0800
Message-Id: <1423118065-6250-4-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1423118065-6250-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <20150204234442.GC20072@google.com>
 <1423118065-6250-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 1776b36..f1fc7cf 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -854,7 +854,7 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
 	struct pci_dn *pdn = pci_get_pdn(dev);
 	int i;
 	struct resource *res, res2;
-	resource_size_t size, end;
+	resource_size_t size;
 	u16 vf_num;
 
 	if (!dev->is_physfn)
-- 
1.7.9.5
