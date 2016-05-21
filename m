Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x241.google.com (mail-lb0-x241.google.com
 [IPv6:2a00:1450:4010:c04::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk4S2J1mzDqL3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:04:24 +1000 (AEST)
Received: by mail-lb0-x241.google.com with SMTP id u2so695813lbo.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:04:24 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, stewart@linux.vnet.ibm.com, vipin@linux.vnet.ibm.com,
 hegdevasant@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com,
 ruscur@russell.cc, shilpa.bhat@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com, jk@ozlabs.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0215/1529] Fix typo
Date: Sat, 21 May 2016 14:04:13 +0200
Message-Id: <20160521120413.11129-1-andrea.gelmini@gelma.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/powerpc/include/asm/opal-api.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 9bb8ddf..70b5cbc 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -802,7 +802,7 @@ struct opal_sg_entry {
 };
 
 /*
- * Candiate image SG list.
+ * Candidate image SG list.
  *
  * length = VER | length
  */
@@ -852,7 +852,7 @@ struct opal_i2c_request {
  * with individual elements being 16 bits wide to fetch the system
  * wide EPOW status. Each element in the buffer will contain the
  * EPOW status in it's bit representation for a particular EPOW sub
- * class as defiend here. So multiple detailed EPOW status bits
+ * class as defined here. So multiple detailed EPOW status bits
  * specific for any sub class can be represented in a single buffer
  * element as it's bit representation.
  */
-- 
2.8.2.534.g1f66975
