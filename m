Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 23B701A382C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 03:11:47 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 16 Sep 2015 11:11:46 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 8D9CB1FF0059
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 11:02:52 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8GHAagA35979354
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 10:10:36 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8GHBgfC024210
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 11:11:42 -0600
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James.Bottomley@HansenPartnership.com,
 nab@linux-iscsi.org, brking@linux.vnet.ibm.com, imunsie@au1.ibm.com,
 dja@ozlabs.au.ibm.com, andrew.donnellan@au1.ibm.com
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Subject: [PATCH v2 30/30] MAINTAINERS: Add cxlflash driver
Date: Wed, 16 Sep 2015 12:11:15 -0500
Message-Id: <1442423475-42658-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add stanza for cxlflash SCSI driver.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 310da42..b0b2c3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3153,6 +3153,15 @@ F:	Documentation/powerpc/cxl.txt
 F:	Documentation/powerpc/cxl.txt
 F:	Documentation/ABI/testing/sysfs-class-cxl
 
+CXLFLASH (IBM Coherent Accelerator Processor Interface CAPI Flash) SCSI DRIVER
+M:	Manoj N. Kumar <manoj@linux.vnet.ibm.com>
+M:	Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
+L:	linux-scsi@vger.kernel.org
+S:	Supported
+F:	drivers/scsi/cxlflash/
+F:	include/uapi/scsi/cxlflash_ioctls.h
+F:	Documentation/powerpc/cxlflash.txt
+
 STMMAC ETHERNET DRIVER
 M:	Giuseppe Cavallaro <peppe.cavallaro@st.com>
 L:	netdev@vger.kernel.org
-- 
2.1.0
