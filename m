Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 697CB2C0382
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 15:42:32 +1000 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 27 Jun 2013 23:42:30 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id BC4AE1FF001C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 23:37:11 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5S5gRhP158512
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 23:42:27 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5S5gRfp023394
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 23:42:27 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3] powerpc/eeh: Update MAINTAINERS
Date: Fri, 28 Jun 2013 13:42:23 +0800
Message-Id: <1372398143-15561-1-git-send-email-shangw@linux.vnet.ibm.com>
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
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5be702c..78e64c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6149,7 +6149,13 @@ M:	Linas Vepstas <linasvepstas@gmail.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/PCI/pci-error-recovery.txt
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
