Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E95EF2C038F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 13:43:03 +1100 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Sat, 18 Jan 2014 12:43:02 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id EA9F42CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 13:42:59 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0I2gkJm10879422
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 13:42:47 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0I2gwGD021883
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 13:42:59 +1100
Subject: [PATCH V3 2/3] powernv: Correct spell error in opal-elog.c
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Sat, 18 Jan 2014 08:13:10 +0530
Message-ID: <20140118024308.13537.71503.stgit@deepthi>
In-Reply-To: <20140118024150.13537.11381.stgit@deepthi>
References: <20140118024150.13537.11381.stgit@deepthi>
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
index 5aa2d86..0f67faa 100644
--- a/arch/powerpc/platforms/powernv/opal-elog.c
+++ b/arch/powerpc/platforms/powernv/opal-elog.c
@@ -26,7 +26,7 @@
 /* Maximum size of a single log on FSP is 16KB */
 #define OPAL_MAX_ERRLOG_SIZE	16384
 
-/* maximu number of records powernv can hold */
+/* Maximum number of records powernv platform can hold */
 #define MAX_NUM_RECORD	128
 
 struct opal_err_log {
