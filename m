Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rCgrQ6n2zzDqDD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 11:27:18 +1000 (AEST)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Sun, 22 May 2016 19:27:16 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: paulus@ozlabs.org, andrea.gelmini@gelma.net
Cc: trivial@kernel.org, oss@buserror.net, linuxppc-dev@lists.ozlabs.org,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: [PATCH] Clarify that adde is an instruction and we mean plural
Date: Mon, 23 May 2016 11:27:01 +1000
Message-Id: <1463966821-14733-1-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <20160522023732.GA23547@fergus.ozlabs.ibm.com>
References: <20160522023732.GA23547@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/lib/checksum_64.S | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_64.S
index 8e6e510..fdec6e6 100644
--- a/arch/powerpc/lib/checksum_64.S
+++ b/arch/powerpc/lib/checksum_64.S
@@ -74,9 +74,9 @@ _GLOBAL(__csum_partial)
 	ld	r11,24(r3)
 
 	/*
-	 * On POWER6 and POWER7 back to back addes take 2 cycles because of
-	 * the XER dependency. This means the fastest this loop can go is
-	 * 16 cycles per iteration. The scheduling of the loop below has
+	 * On POWER6 and POWER7 back to back adde instructions take 2 cycles
+	 * because of the XER dependency. This means the fastest this loop can
+	 * go is 16 cycles per iteration. The scheduling of the loop below has
 	 * been shown to hit this on both POWER6 and POWER7.
 	 */
 	.align 5
@@ -275,9 +275,9 @@ source;	ld	r10,16(r3)
 source;	ld	r11,24(r3)
 
 	/*
-	 * On POWER6 and POWER7 back to back addes take 2 cycles because of
-	 * the XER dependency. This means the fastest this loop can go is
-	 * 16 cycles per iteration. The scheduling of the loop below has
+	 * On POWER6 and POWER7 back to back adde instructions take 2 cycles
+	 * because of the XER dependency. This means the fastest this loop can
+	 * go is 16 cycles per iteration. The scheduling of the loop below has
 	 * been shown to hit this on both POWER6 and POWER7.
 	 */
 	.align 5
-- 
2.5.5
