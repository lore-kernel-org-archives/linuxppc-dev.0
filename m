Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D212D2C036C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 06:29:38 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 4 Feb 2014 05:29:37 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 30C702CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 06:29:35 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s13JTMj110223880
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 06:29:22 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s13JTYDr009956
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 06:29:34 +1100
Received: from [192.168.1.7] ([9.79.188.145])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s13JTXCN009935
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 06:29:34 +1100
Subject: [PATCH V4 2/3] powerpc/powernv: Correct spell error in opal-elog.c
To: linuxppc-dev@lists.ozlabs.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Tue, 04 Feb 2014 00:59:53 +0530
Message-ID: <20140203192946.7790.5676.stgit@deepthi>
In-Reply-To: <20140203192915.7790.20325.stgit@deepthi>
References: <20140203192915.7790.20325.stgit@deepthi>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Correct spell error in opal-elog.c

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-elog.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
index 0a03b60..13874b1 100644
--- a/arch/powerpc/platforms/powernv/opal-elog.c
+++ b/arch/powerpc/platforms/powernv/opal-elog.c
@@ -26,7 +26,7 @@
 /* Maximum size of a single log on FSP is 16KB */
 #define OPAL_MAX_ERRLOG_SIZE	16384
 
-/* maximu number of records powernv can hold */
+/* Maximum number of records powernv platform can hold */
 #define MAX_NUM_RECORD	128
 
 struct opal_err_log {
