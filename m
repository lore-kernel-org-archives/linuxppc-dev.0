Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EEC322C02EC
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2012 09:59:16 +1000 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 12 Jul 2012 17:59:12 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 3EE5E3E40047
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2012 23:59:08 +0000 (WET)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6CNx8LQ287166
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2012 17:59:08 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6CNx7iJ028023
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2012 17:59:08 -0600
Date: Thu, 12 Jul 2012 16:59:12 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 1/2] power: Define PV_POWER7P
Message-ID: <20120712235912.GA19909@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: michaele@au1.ibm.com, Anton Blanchard <anton@au1.ibm.com>,
 sukadev@us.ibm.com, linuxppc-dev@ozlabs.org, cel@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Tue, 3 Jul 2012 13:32:46 -0700
Subject: [PATCH 1/2] power: Define PV_POWER7P

This change is based on the patch that Carl Love posted to LKML

	https://lkml.org/lkml/2012/6/22/309

It is included here for completeness and to enable building. When
the above patch is merged, this patch can be ignored.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/reg.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index f0cb7f4..b3fc2c1 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1014,6 +1014,7 @@
 #define PV_970FX	0x003C
 #define PV_POWER6	0x003E
 #define PV_POWER7	0x003F
+#define PV_POWER7P	0x004A
 #define PV_630		0x0040
 #define PV_630p	0x0041
 #define PV_970MP	0x0044
-- 
1.7.1
