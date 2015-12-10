Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 174FA1A118A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 09:54:37 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Thu, 10 Dec 2015 15:54:36 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id BE54F1FF0049
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 15:42:43 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBAMsW2e26935504
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 15:54:32 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBAMsU4i015637
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 15:54:32 -0700
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: [PATCH 3/6] cxlflash: Updated date of the driver
Date: Thu, 10 Dec 2015 16:54:03 -0600
Message-Id: <1449788043-23131-1-git-send-email-ukrishn@linux.vnet.ibm.com>
In-Reply-To: <1449787867-23015-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1449787867-23015-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This change is to update the date when last change was
made to the cxlflash driver

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/cxlflash/main.h b/drivers/scsi/cxlflash/main.h
index 6032456..ddc4a97 100644
--- a/drivers/scsi/cxlflash/main.h
+++ b/drivers/scsi/cxlflash/main.h
@@ -22,7 +22,7 @@
 
 #define CXLFLASH_NAME		"cxlflash"
 #define CXLFLASH_ADAPTER_NAME	"IBM POWER CXL Flash Adapter"
-#define CXLFLASH_DRIVER_DATE	"(August 13, 2015)"
+#define CXLFLASH_DRIVER_DATE	"(October 26, 2015)"
 
 #define PCI_DEVICE_ID_IBM_CORSA	0x04F0
 #define CXLFLASH_SUBS_DEV_ID	0x04F0
-- 
2.1.0
