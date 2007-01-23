Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4ED8DDDF32
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 10:18:09 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l0NNI1ck063060
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 23:18:01 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l0NNI0bt2629818
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 00:18:00 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0NNHxOj009230
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 00:18:00 +0100
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, hch@infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	openib-general@openib.org, openfabrics-ewg@openib.org
Subject: [PATCH 2.6.21 4/4] ehca: remove obsolete prototypes
Date: Wed, 24 Jan 2007 00:14:18 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200701240014.19439.hnguyen@linux.vnet.ibm.com>
Cc: raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is a patch for ehca_classes.h that removes obsolete prototypes.
Thanks
Nam


Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_classes.h |   14 --------------
 1 files changed, 14 deletions(-)


diff -Nurp infiniband_orig/drivers/infiniband/hw/ehca/ehca_classes.h infiniband_work/drivers/infiniband/hw/ehca/ehca_classes.h
--- infiniband_orig/drivers/infiniband/hw/ehca/ehca_classes.h	2007-01-20 00:21:21.000000000 +0100
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_classes.h	2007-01-20 00:23:46.000000000 +0100
@@ -250,20 +250,6 @@ struct ehca_ucontext {
 	struct ib_ucontext ib_ucontext;
 };
 
-struct ehca_module *ehca_module_new(void);
-
-int ehca_module_delete(struct ehca_module *me);
-
-int ehca_eq_ctor(struct ehca_eq *eq);
-
-int ehca_eq_dtor(struct ehca_eq *eq);
-
-struct ehca_shca *ehca_shca_new(void);
-
-int ehca_shca_delete(struct ehca_shca *me);
-
-struct ehca_sport *ehca_sport_new(struct ehca_shca *anchor);
-
 int ehca_init_pd_cache(void);
 void ehca_cleanup_pd_cache(void);
 int ehca_init_cq_cache(void);
