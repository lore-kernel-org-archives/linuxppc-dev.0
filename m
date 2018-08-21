Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vXtP2cggzDrWY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 11:20:44 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7L1IqVs102491
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 21:20:42 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m04x1ymec-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 21:20:42 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 20 Aug 2018 19:20:41 -0600
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
 bhelgaas@google.com, linux-kernel@vger.kernel.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [PATCH] MAINTAINERS: add maintainer entries for RPA pci hotplug
 drivers
Date: Mon, 20 Aug 2018 18:20:31 -0700
Message-Id: <1534814431-20112-1-git-send-email-tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adding myself as maintiner of the IBM RPA hotplug modules located in
drivers/pci/hotplug directory. These modules provide kernel interfaces
for support of Dynamic Logical Partitioning (DLPAR) of Logical and
Physical IO slots, and hotplug of physical PCI slots of a PHB on
RPA-compliant ppc64 platforms (pseries).

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5df1b36..7b5dc3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6984,6 +6984,20 @@ F:	drivers/crypto/vmx/aes*
 F:	drivers/crypto/vmx/ghash*
 F:	drivers/crypto/vmx/ppc-xlate.pl
 
+IBM Power PCI Hotplug Driver for RPA-compliant PPC64 platform
+M:	Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
+L:	linux-pci@vger.kernel.org
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Supported
+F:	drivers/pci/hotplug/rpaphp*
+
+IBM Power IO DLPAR Driver for RPA-compliant PPC64 platform
+M:	Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
+L:	linux-pci@vger.kernel.org
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Supported
+F:	drivers/pci/hotplug/rpadlpar*
+
 IBM ServeRAID RAID DRIVER
 S:	Orphan
 F:	drivers/scsi/ips.*
-- 
1.8.3.1
