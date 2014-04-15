Return-Path: <cody@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 104FD140093
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Apr 2014 03:11:17 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Tue, 15 Apr 2014 11:11:15 -0600
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 48898C9001B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 13:11:08 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3FHBCtL4981210
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 17:11:12 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3FHBBK8022598
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 13:11:11 -0400
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH v2 3/6] powerpc/perf/hv-gpci: make device attr static
Date: Tue, 15 Apr 2014 10:10:52 -0700
Message-Id: <1397581855-4585-4-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1397581855-4585-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1397581855-4585-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: Linux PPC <linuxppc-dev@lists.ozlabs.org>,
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

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-gpci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
index 8fee1dc..c9d399a 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -78,7 +78,7 @@ static ssize_t kernel_version_show(struct device *dev,
 	return sprintf(page, "0x%x\n", COUNTER_INFO_VERSION_CURRENT);
 }
 
-DEVICE_ATTR_RO(kernel_version);
+static DEVICE_ATTR_RO(kernel_version);
 HV_CAPS_ATTR(version, "0x%x\n");
 HV_CAPS_ATTR(ga, "%d\n");
 HV_CAPS_ATTR(expanded, "%d\n");
-- 
1.9.2
