Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5B797DDE3E
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 04:40:52 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78Ieni8012988
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:40:49 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78Ienk0475348
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:40:49 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78Iemv8015770
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:40:49 -0400
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, openib-general@openib.org
Subject: [PATCH 3/7] IB/ehca: Add 1 is not longer needed because of firmware
	interface change
Date: Wed, 8 Aug 2007 20:40:47 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200708082040.47926.ossrosch@linux.vnet.ibm.com>
Cc: fenkes@de.ibm.com, raisch@de.ibm.com,
	"\"Hoang-Nam Nguyen\" @dyn-9-152-249-53"
	<Hoang-Nam.Nguyen@d01av01.pok.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Stefan Roscher <stefan.roscher@de.ibm.com>
---
 drivers/infiniband/hw/ehca/hcp_if.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/hcp_if.c b/drivers/infiniband/hw/ehca/hcp_if.c
index 24f4541..8534061 100644
--- a/drivers/infiniband/hw/ehca/hcp_if.c
+++ b/drivers/infiniband/hw/ehca/hcp_if.c
@@ -317,9 +317,9 @@ u64 hipz_h_alloc_resource_qp(const struct ipz_adapter_handle adapter_handle,
 
 	max_r10_reg =
 		EHCA_BMASK_SET(H_ALL_RES_QP_MAX_OUTST_SEND_WR,
-			       parms->squeue.max_wr + 1)
+			       parms->squeue.max_wr)
 		| EHCA_BMASK_SET(H_ALL_RES_QP_MAX_OUTST_RECV_WR,
-				 parms->rqueue.max_wr + 1)
+				 parms->rqueue.max_wr)
 		| EHCA_BMASK_SET(H_ALL_RES_QP_MAX_SEND_SGE,
 				 parms->squeue.max_sge)
 		| EHCA_BMASK_SET(H_ALL_RES_QP_MAX_RECV_SGE,
-- 
1.5.2
