Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e1.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A73D62C0119
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2012 07:29:24 +1000 (EST)
Received: from /spool/local
 by e1.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 16 Jul 2012 17:29:19 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 346F938C8059
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2012 17:21:53 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6GLLqYG353230
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2012 17:21:52 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6GLLomL020972
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2012 18:21:52 -0300
Date: Mon, 16 Jul 2012 14:22:02 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: benh@us.ibm.com
Subject: [PATCH 1/2][v2] powerpc: Define PV_POWER7p
Message-ID: <20120716212202.GA14033@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: michaele@au1.ibm.com, Anton Blanchard <anton@au1.ibm.com>,
 linuxppc-dev@ozlabs.org, cel@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 7e47842eb50d56bdeba44ea526979ee5160dbbc0 Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Tue, 3 Jul 2012 13:32:46 -0700
Subject: [PATCH 1/2][v2] powerpc: Define PV_POWER7p

This change is based on the patch that Carl Love posted to LKML

	https://lkml.org/lkml/2012/6/22/309

It is included here for completeness and to enable building. When
the above patch is merged, this patch can be ignored.

Changelog[v2]:
	- [Gabriel Paubert] Rename PV_POWER7P to PV_POWER7p and keep the
	  processor versions in numeric order.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/reg.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index f0cb7f4..65b6164 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1015,9 +1015,10 @@
 #define PV_POWER6	0x003E
 #define PV_POWER7	0x003F
 #define PV_630		0x0040
-#define PV_630p	0x0041
+#define PV_630p		0x0041
 #define PV_970MP	0x0044
 #define PV_970GX	0x0045
+#define PV_POWER7p	0x004A
 #define PV_BE		0x0070
 #define PV_PA6T		0x0090
 
-- 
1.7.1
