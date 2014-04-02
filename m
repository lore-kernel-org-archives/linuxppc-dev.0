Return-Path: <cody@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 867F4140132
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Apr 2014 09:11:04 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Wed, 2 Apr 2014 16:11:01 -0600
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3792A38C803D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Apr 2014 18:11:00 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s32MB0134784578
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Apr 2014 22:11:00 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s32MAxSI009676
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Apr 2014 18:10:59 -0400
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/2] fixup: "powerpc/perf: Add support for the hv gpci (get
 performance counter info) interface"
Date: Wed,  2 Apr 2014 15:10:54 -0700
Message-Id: <1396476654-20623-3-git-send-email-cody@linux.vnet.ibm.com>
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
 arch/powerpc/perf/hv-gpci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
index 278ba7b..f6c471d 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -279,7 +279,7 @@ static int hv_gpci_init(void)
 
 	hret = hv_perf_caps_get(&caps);
 	if (hret) {
-		pr_info("could not obtain capabilities, error 0x%80lx, not enabling\n",
+		pr_info("could not obtain capabilities, not enabling (%ld)\n",
 				hret);
 		return -ENODEV;
 	}
-- 
1.9.1
