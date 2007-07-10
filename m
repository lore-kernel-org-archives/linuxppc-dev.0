Return-Path: <brking@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3149BDDFCB
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 00:41:18 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6AEgSNO018600
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 10:42:28 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6AEfGR2529168
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 10:41:16 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6AEfFQE021951
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 10:41:15 -0400
Subject: [PATCH 1/1] powerpc: Add H_ILLAN_ATTRIBUTES
To: paulus@samba.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Tue, 10 Jul 2007 09:41:14 -0500
Message-Id: <11840784743083-patch-mail.ibm.com>
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Adds the H_ILLAN_ATTRIBUTES hcall

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 linux-2.6-bjking1/include/asm-powerpc/hvcall.h |    1 +
 1 file changed, 1 insertion(+)

diff -puN include/asm-powerpc/hvcall.h~powerpc_illan_attrs include/asm-powerpc/hvcall.h
--- linux-2.6/include/asm-powerpc/hvcall.h~powerpc_illan_attrs	2007-07-10 09:37:57.000000000 -0500
+++ linux-2.6-bjking1/include/asm-powerpc/hvcall.h	2007-07-10 09:37:57.000000000 -0500
@@ -206,6 +206,7 @@
 #define H_FREE_LOGICAL_LAN_BUFFER 0x1D4
 #define H_QUERY_INT_STATE       0x1E4
 #define H_POLL_PENDING		0x1D8
+#define H_ILLAN_ATTRIBUTES	0x244
 #define H_JOIN			0x298
 #define H_VASI_STATE            0x2A4
 #define H_ENABLE_CRQ		0x2B0
_
