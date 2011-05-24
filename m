Return-Path: <brking@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8C567B6F77
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 May 2011 23:41:04 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4ODTf1f015141
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2011 09:29:41 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4ODeuoF1380438
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2011 09:40:56 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p4ODet2K006412
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2011 10:40:56 -0300
Message-Id: <201105241340.p4ODerDL006322@d01av02.pok.ibm.com>
Subject: [PATCH 1/1] powerpc: Update MAX_HCALL_OPCODE to reflect page
	coalescing
To: benh@kernel.crashing.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Tue, 24 May 2011 08:40:54 -0500
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


When page coalescing support was added recently, the MAX_HCALL_OPCODE
define was not updated for the newly added H_GET_MPP_X hcall.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/include/asm/hvcall.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/powerpc/include/asm/hvcall.h~powerpc_max_hcall_opcode arch/powerpc/include/asm/hvcall.h
--- linux-2.6/arch/powerpc/include/asm/hvcall.h~powerpc_max_hcall_opcode	2011-05-20 09:33:45.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/include/asm/hvcall.h	2011-05-20 09:33:58.000000000 -0500
@@ -236,7 +236,7 @@
 #define H_HOME_NODE_ASSOCIATIVITY 0x2EC
 #define H_BEST_ENERGY		0x2F4
 #define H_GET_MPP_X		0x314
-#define MAX_HCALL_OPCODE	H_BEST_ENERGY
+#define MAX_HCALL_OPCODE	H_GET_MPP_X
 
 #ifndef __ASSEMBLY__
 
_
