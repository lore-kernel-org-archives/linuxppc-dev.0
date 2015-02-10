Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 91CBF1A03D7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:27:39 +1100 (AEDT)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 9 Feb 2015 19:27:37 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 8D0353E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 19:27:34 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t1A2Rdbd36634848
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 19:27:39 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A2RX2f017522
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 19:27:34 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH 17/18] powerpc/powernv: s/u8/uint8_t/ to match firmware in
 opal.h
Date: Tue, 10 Feb 2015 13:26:59 +1100
Message-Id: <1423535220-6322-18-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1423535220-6322-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1423535220-6322-1-git-send-email-stewart@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
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
 arch/powerpc/include/asm/opal.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 2441f36..68ce7ef 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -612,13 +612,13 @@ struct OpalIoP7IOCErrorData {
 			__be64 biLdcp2;		/* 3C0110, 3C0128 */
 			__be64 biFenceStatus;	/* 3C0130, 3C0130 */
 
-			    u8 biDownbound;	/* BI Downbound or Upbound */
+			uint8_t biDownbound;	/* BI Downbound or Upbound */
 		}bi;
 		struct OpalIoP7IOCCiErrorData {
 			__be64 ciPortStatus;	/* 3Dn008 */
 			__be64 ciPortLdcp;	/* 3Dn010 */
 
-			    u8 ciPort;		/* Index of CI port: 0/1 */
+			uint8_t ciPort;		/* Index of CI port: 0/1 */
 		}ci;
 	};
 };
-- 
1.7.10.4
