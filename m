Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DF465DE3C1
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 01:18:26 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3LFFHBf008828
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 09:15:17 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3LFILsG053314
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 09:18:21 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3LFIIY3009632
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 09:18:21 -0600
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	"OF-EWG" <ewg@lists.openfabrics.org>,
	LKML <linux-kernel@vger.kernel.org>, Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 3/3] IB/ehca: Increment version number
Date: Tue, 21 Apr 2009 17:18:16 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200904211718.16434.ossrosch@linux.vnet.ibm.com>
Cc: fenkes@de.ibm.com, stefan.roscher@de.ibm.com, alexschm@de.ibm.com,
	raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Stefan Roscher <stefan.roscher@de.ibm.com>

---
 drivers/infiniband/hw/ehca/ehca_main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 368311c..85905ab 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -52,7 +52,7 @@
 #include "ehca_tools.h"
 #include "hcp_if.h"
 
-#define HCAD_VERSION "0026"
+#define HCAD_VERSION "0027"
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Christoph Raisch <raisch@de.ibm.com>");
-- 
1.5.5
