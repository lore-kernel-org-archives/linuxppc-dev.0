Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 12AFD2C0182
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 12:25:25 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 28 Jun 2013 03:25:23 +0100
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 75C5638C804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 22:25:21 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5S2PMx8290312
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 22:25:22 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5S2PKHm012657
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 22:25:22 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/eeh: Update MAINTAINERS
Date: Fri, 28 Jun 2013 10:25:16 +0800
Message-Id: <1372386316-24086-1-git-send-email-shangw@linux.vnet.ibm.com>
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
 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5be702c..c724a3a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6149,7 +6149,14 @@ M:	Linas Vepstas <linasvepstas@gmail.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/PCI/pci-error-recovery.txt
+F:	drivers/pci/pcie/aer/
+
+ENHANCED ERROR HANDLING (EEH)
+M:	Gavin Shan <shangw@linux.vnet.ibm.com>
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Supported
 F:	Documentation/powerpc/eeh-pci-error-recovery.txt
+F:	arch/powerpc/kernel/eeh*.c
 
 PCI SUBSYSTEM
 M:	Bjorn Helgaas <bhelgaas@google.com>
-- 
1.7.5.4
