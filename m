Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 987FD1A0519
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 21:02:09 +1100 (AEDT)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Tue, 13 Jan 2015 03:01:18 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 3C5A81FF001A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jan 2015 17:20:31 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0D0Vx7226804378
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jan 2015 17:31:59 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0D0VkOl004679
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jan 2015 17:31:47 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org
Subject: [PATCH 1/2] MAINTAINERS: ibmvscsi driver maintainer change
Date: Mon, 12 Jan 2015 16:31:34 -0800
Message-Id: <1421109095-18613-1-git-send-email-tyreld@linux.vnet.ibm.com>
Cc: brking@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com,
 linux-kernel@vger.linux.org, linuxppc-dev@lists.ozlabs.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change maintainer of ibmvscsi driver to Tyrel Datwyler.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 79b2e4b..a646b94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4754,7 +4754,7 @@ S:	Supported
 F:	drivers/net/ethernet/ibm/ibmveth.*
 
 IBM Power Virtual SCSI Device Drivers
-M:	Nathan Fontenot <nfont@linux.vnet.ibm.com>
+M:	Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
 L:	linux-scsi@vger.kernel.org
 S:	Supported
 F:	drivers/scsi/ibmvscsi/ibmvscsi*
-- 
1.7.12.2
