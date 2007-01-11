Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C4B14DE005
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 06:13:18 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l0BJDEYQ040724
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 19:13:14 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id l0BJDEbg1835222
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 19:13:14 GMT
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0BJDDNe003951
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 19:13:14 GMT
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, hch@infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	openfabrics-ewg@openib.org, openib-general@openib.org
Subject: [PATCH/RFC 2.6.21 5/5] ehca: ehca_main.c: version numbering
Date: Thu, 11 Jan 2007 20:09:30 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200701112009.31068.hnguyen@linux.vnet.ibm.com>
Cc: raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Roland!
This is a patch for ehca_main.c. It mainly updates ehca version appropriately.
Also the abi_version is increased in order to distinguish this from earlier
releases.
Thanks
Nam


Signed-off-by Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_main.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 6574fbb..839beaa 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -52,7 +52,7 @@ #include "hcp_if.h"
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Christoph Raisch <raisch@de.ibm.com>");
 MODULE_DESCRIPTION("IBM eServer HCA InfiniBand Device Driver");
-MODULE_VERSION("SVNEHCA_0019");
+MODULE_VERSION("SVNEHCA_0020");
 
 int ehca_open_aqp1     = 0;
 int ehca_debug_level   = 0;
@@ -288,7 +287,7 @@ int ehca_init_device(struct ehca_shca *s
 	strlcpy(shca->ib_device.name, "ehca%d", IB_DEVICE_NAME_MAX);
 	shca->ib_device.owner               = THIS_MODULE;
 
-	shca->ib_device.uverbs_abi_ver	    = 5;
+	shca->ib_device.uverbs_abi_ver	    = 6;
 	shca->ib_device.uverbs_cmd_mask	    =
 		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT)		|
 		(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE)	|
@@ -790,7 +789,7 @@ int __init ehca_module_init(void)
 	int ret;
 
 	printk(KERN_INFO "eHCA Infiniband Device Driver "
-	                 "(Rel.: SVNEHCA_0019)\n");
+	                 "(Rel.: SVNEHCA_0020)\n");
 	idr_init(&ehca_qp_idr);
 	idr_init(&ehca_cq_idr);
 	spin_lock_init(&ehca_qp_idr_lock);
