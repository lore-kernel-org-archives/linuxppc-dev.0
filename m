Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B1B5D2C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 23:16:48 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 28 Jun 2013 07:16:46 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id A0D2D3E40044
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 07:12:05 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5SDCJQS048482
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 07:12:22 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5SDCI3m022417
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 07:12:18 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4] powerpc/eeh: Update MAINTAINERS
Date: Fri, 28 Jun 2013 21:12:14 +0800
Message-Id: <1372425135-6046-1-git-send-email-shangw@linux.vnet.ibm.com>
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
 MAINTAINERS |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5be702c..ebeceeb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3103,6 +3103,13 @@ M:	Maxim Levitsky <maximlevitsky@gmail.com>
 S:	Maintained
 F:	drivers/media/rc/ene_ir.*
 
+ENHANCED ERROR HANDLING (EEH)
+M:	Gavin Shan <shangw@linux.vnet.ibm.com>
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Supported
+F:	Documentation/powerpc/eeh-pci-error-recovery.txt
+F:	arch/powerpc/kernel/eeh*.c
+
 EPSON S1D13XXX FRAMEBUFFER DRIVER
 M:	Kristoffer Ericson <kristoffer.ericson@gmail.com>
 S:	Maintained
@@ -6149,7 +6156,6 @@ M:	Linas Vepstas <linasvepstas@gmail.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/PCI/pci-error-recovery.txt
-F:	Documentation/powerpc/eeh-pci-error-recovery.txt
 
 PCI SUBSYSTEM
 M:	Bjorn Helgaas <bhelgaas@google.com>
-- 
1.7.5.4
