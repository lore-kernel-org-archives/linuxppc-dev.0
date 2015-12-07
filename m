Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6507A1A0E5A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 09:04:20 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 7 Dec 2015 15:04:18 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 18C3819D8045
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Dec 2015 14:52:20 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB7M4Eid21364958
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Dec 2015 15:04:14 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB7M4Dwe028925
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Dec 2015 15:04:14 -0700
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
Cc: "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Subject: [PATCH] cxl: Enable PCI device ID for future IBM CXL adapter
Date: Mon,  7 Dec 2015 16:03:32 -0600
Message-Id: <1449525812-46752-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for future IBM Coherent Accelerator (CXL) device
with ID of 0x0601.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
---
 drivers/misc/cxl/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 13a97f8..3171e96 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -138,6 +138,7 @@ static DEFINE_PCI_DEVICE_TABLE(cxl_pci_tbl) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0477), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x044b), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x04cf), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0601), },
 	{ PCI_DEVICE_CLASS(0x120000, ~0), },
 
 	{ }
-- 
2.1.0
