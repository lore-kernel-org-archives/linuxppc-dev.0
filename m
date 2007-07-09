Return-Path: <fenkes@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E1927DDF0A
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jul 2007 23:21:01 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l69DKvp7126978
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 13:20:57 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l69DKvxq2035758
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 15:20:57 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l69DKutm015616
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 15:20:57 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 01/13] IB/ehca: change scaling_code parameter description to
	match default value
Date: Mon, 9 Jul 2007 15:20:55 +0200
References: <200707091502.22407.fenkes@de.ibm.com>
In-Reply-To: <200707091502.22407.fenkes@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707091520.56294.fenkes@de.ibm.com>
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
 drivers/infiniband/hw/ehca/ehca_main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index c3f99f3..fea199f 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -94,7 +94,7 @@ MODULE_PARM_DESC(poll_all_eqs,
 MODULE_PARM_DESC(static_rate,
 		 "set permanent static rate (default: disabled)");
 MODULE_PARM_DESC(scaling_code,
-		 "set scaling code (0: disabled, 1: enabled/default)");
+		 "set scaling code (0: disabled/default, 1: enabled)");
 
 spinlock_t ehca_qp_idr_lock;
 spinlock_t ehca_cq_idr_lock;
-- 
1.5.2
