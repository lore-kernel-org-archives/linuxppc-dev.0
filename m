Return-Path: <fenkes@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E150FDDDE7
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 02:15:05 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id l8DGF0Kp024412
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 16:15:00 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8DGF01Q2248766
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 18:15:00 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8DGExxi025460
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 18:15:00 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH 1/3] IB/ehca: Fix large page HW cap defines
Date: Thu, 13 Sep 2007 18:14:58 +0200
References: <200709131814.13937.fenkes@de.ibm.com>
In-Reply-To: <200709131814.13937.fenkes@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709131814.59307.fenkes@de.ibm.com>
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

From: Hoang-Nam Nguyen <hnguyen@de.ibm.com>

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_classes.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_classes.h b/drivers/infiniband/hw/ehca/ehca_classes.h
index 206d4eb..c2edd4c 100644
--- a/drivers/infiniband/hw/ehca/ehca_classes.h
+++ b/drivers/infiniband/hw/ehca/ehca_classes.h
@@ -99,10 +99,10 @@ struct ehca_sport {
 	struct ehca_sma_attr saved_attr;
 };
 
-#define HCA_CAP_MR_PGSIZE_4K  1
-#define HCA_CAP_MR_PGSIZE_64K 2
-#define HCA_CAP_MR_PGSIZE_1M  4
-#define HCA_CAP_MR_PGSIZE_16M 8
+#define HCA_CAP_MR_PGSIZE_4K  0x80000000
+#define HCA_CAP_MR_PGSIZE_64K 0x40000000
+#define HCA_CAP_MR_PGSIZE_1M  0x20000000
+#define HCA_CAP_MR_PGSIZE_16M 0x10000000
 
 struct ehca_shca {
 	struct ib_device ib_device;
-- 
1.5.2
