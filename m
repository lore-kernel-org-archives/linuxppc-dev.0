Return-Path: <cody@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 86F8A140133
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Apr 2014 09:11:04 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Wed, 2 Apr 2014 16:11:02 -0600
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 6B0396E8040
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Apr 2014 18:10:53 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s32MAxQL60620990
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Apr 2014 22:10:59 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s32MAwMr009658
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Apr 2014 18:10:59 -0400
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/2] fixup: "powerpc/perf: Add support for the hv 24x7
 interface"
Date: Wed,  2 Apr 2014 15:10:53 -0700
Message-Id: <1396476654-20623-2-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1396476654-20623-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1396476654-20623-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: Linux PPC <linuxppc-dev@lists.ozlabs.org>, cody+local@linux.vnet.ibm.com,
 LKML <linux-kernel@vger.kernel.org>, David.Laight@aculab.com,
 Anton Blanchard <anton@samba.org>, Cody P Schafer <cody@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make the "not enabled" message less awful.

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 297c9105..3246ea2 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -491,7 +491,7 @@ static int hv_24x7_init(void)
 
 	hret = hv_perf_caps_get(&caps);
 	if (hret) {
-		pr_info("could not obtain capabilities, error 0x%80lx, not enabling\n",
+		pr_info("could not obtain capabilities, not enabling (%ld)\n",
 				hret);
 		return -ENODEV;
 	}
-- 
1.9.1
