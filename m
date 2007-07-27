Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate8.uk.ibm.com (mtagate8.uk.ibm.com [195.212.29.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E969BDDE3C
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 20:43:22 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate8.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l6RAhHs0445360
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 10:43:17 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6RAhHsp2220254
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 11:43:17 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6RAhAb3009517
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 11:43:11 +0100
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, general@lists.openfabrics.org
Subject: [PATCH 2/2] ehca: correction include order according kernel coding
	style
Date: Fri, 27 Jul 2007 12:55:19 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707271255.19456.hnguyen@linux.vnet.ibm.com>
Cc: raisch@de.ibm.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=46rom a2794450cbee597cefd7b6e159257583c459d358 Mon Sep 17 00:00:00 2001
=46rom: Hoang-Nam Nguyen <hnguyen at de.ibm.com>
Date: Fri, 27 Jul 2007 10:26:40 +0200
Subject: [PATCH] correction include order according kernel coding style

Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
=2D--
 drivers/infiniband/hw/ehca/ehca_mrmw.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_mrmw.c b/drivers/infiniband/hw=
/ehca/ehca_mrmw.c
index 773ac3f..1180b65 100644
=2D-- a/drivers/infiniband/hw/ehca/ehca_mrmw.c
+++ b/drivers/infiniband/hw/ehca/ehca_mrmw.c
@@ -40,9 +40,8 @@
  * POSSIBILITY OF SUCH DAMAGE.
  */
=20
=2D#include <rdma/ib_umem.h>
=2D
 #include <asm/current.h>
+#include <rdma/ib_umem.h>
=20
 #include "ehca_iverbs.h"
 #include "ehca_mrmw.h"
=2D-=20
1.5.2
