Return-Path: <fenkes@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 307F4DDEB9
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 23:29:13 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l8BDT9OK738782
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 13:29:09 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8BDT8rQ2121894
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 15:29:08 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8BDT8Sr011847
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 15:29:08 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH 02/12] IB/ehca: Add 1 is not longer needed because of firmware
	interface change
References: <200709111518.26276.fenkes@de.ibm.com>
In-Reply-To: <200709111518.26276.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Tue, 11 Sep 2007 15:29:07 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709111529.07935.fenkes@de.ibm.com>
Cc: Stefan Roscher <stefan.roscher@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stefan Roscher <stefan.roscher@de.ibm.com>

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
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
