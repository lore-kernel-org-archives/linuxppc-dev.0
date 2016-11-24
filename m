Return-Path: <geliangtang@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPgmD2YSPzDw6L
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 00:58:52 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id e9so3425723pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 05:58:52 -0800 (PST)
From: Geliang Tang <geliangtang@gmail.com>
To: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Geliang Tang <geliangtang@gmail.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ibmvnic: drop duplicate header seq_file.h
Date: Thu, 24 Nov 2016 21:58:29 +0800
Message-Id: <9f2baee4e0a81ba8b5089a2b5a42f67678de4b06.1479989017.git.geliangtang@gmail.com>
In-Reply-To: <15299de49216a2360976ca37ff774cae9d27d88b.1479991297.git.geliangtang@gmail.com>
References: <15299de49216a2360976ca37ff774cae9d27d88b.1479991297.git.geliangtang@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Drop duplicate header seq_file.h from ibmvnic.c.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 1e486d1..c125966 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -74,7 +74,6 @@
 #include <asm/iommu.h>
 #include <linux/uaccess.h>
 #include <asm/firmware.h>
-#include <linux/seq_file.h>
 #include <linux/workqueue.h>
 
 #include "ibmvnic.h"
-- 
2.9.3
