Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 057E82C0359
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 11:59:56 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 27 Jun 2013 21:59:52 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 0BB69C90052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 21:59:50 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5S1xoCL307604
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 21:59:50 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5S1xnIj012461
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 21:59:50 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/eeh: Update MAINTAINERS
Date: Fri, 28 Jun 2013 09:59:44 +0800
Message-Id: <1372384784-20788-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update MAINTAINERS to reflect recent changes.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 MAINTAINERS |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5be702c..b447392 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6146,10 +6146,14 @@ F:	drivers/firmware/pcdp.*
 
 PCI ERROR RECOVERY
 M:	Linas Vepstas <linasvepstas@gmail.com>
+M:	Gavin Shan <shangw@linux.vnet.ibm.com>
 L:	linux-pci@vger.kernel.org
+L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 F:	Documentation/PCI/pci-error-recovery.txt
 F:	Documentation/powerpc/eeh-pci-error-recovery.txt
+F:	arch/powerpc/kernel/eeh*.c
+F:	drivers/pci/pcie/aer/
 
 PCI SUBSYSTEM
 M:	Bjorn Helgaas <bhelgaas@google.com>
-- 
1.7.5.4
