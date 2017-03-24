Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vqSsP081WzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 03:04:08 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2OFx3Cv032568
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 12:04:07 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29cm3ujfea-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 12:04:06 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Fri, 24 Mar 2017 10:04:05 -0600
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Subject: [PATCH v2] cxl: Enable PCI device IDs for future IBM CXL adapters
Date: Fri, 24 Mar 2017 11:03:19 -0500
Message-Id: <1490371400-33398-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for future IBM Coherent Accelerator (CXL) devices
with an IDs of 0x0623 and 0x0628.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
Changes in v2:
 - Add device ID 0x0628

 drivers/misc/cxl/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 80a87ab..dd606a2 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -123,6 +123,8 @@ static const struct pci_device_id cxl_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x044b), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x04cf), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0601), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0623), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0628), },
 	{ PCI_DEVICE_CLASS(0x120000, ~0), },
 
 	{ }
-- 
2.1.0
