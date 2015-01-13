Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D8A9F1A0567
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 11:31:55 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 12 Jan 2015 17:31:53 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id CB7CC1FF001C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jan 2015 17:20:35 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0D0Ucei30081182
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jan 2015 17:30:38 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0D0VpbZ005007
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jan 2015 17:31:51 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org
Subject: [PATCH 2/2] MAINTAINERS: ibmvfc driver maintainer change
Date: Mon, 12 Jan 2015 16:31:35 -0800
Message-Id: <1421109095-18613-2-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1421109095-18613-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1421109095-18613-1-git-send-email-tyreld@linux.vnet.ibm.com>
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

Change maintainer of ibmvfc driver to Tyrel Datwyler.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a646b94..f0d7593 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4761,7 +4761,7 @@ F:	drivers/scsi/ibmvscsi/ibmvscsi*
 F:	drivers/scsi/ibmvscsi/viosrp.h
 
 IBM Power Virtual FC Device Drivers
-M:	Brian King <brking@linux.vnet.ibm.com>
+M:	Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
 L:	linux-scsi@vger.kernel.org
 S:	Supported
 F:	drivers/scsi/ibmvscsi/ibmvfc*
-- 
1.7.12.2
