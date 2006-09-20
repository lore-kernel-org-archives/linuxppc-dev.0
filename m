Return-Path: <jdub@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5D60467BAF
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 00:09:41 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8KE9cPW017925
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 10:09:38 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8KE9cHZ344154
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 08:09:38 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8KE9bV5030095
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 08:09:38 -0600
Subject: [PATCH] 40x: Fix debug status register defines
From: Josh Boyer <jdub@us.ibm.com>
To: paulus@samba.org, mporter@embeddedalley.com
Content-Type: text/plain
Date: Wed, 20 Sep 2006 09:11:59 -0500
Message-Id: <1158761519.3121.35.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes some debug register defines on PPC 40x that were incorrect.

Signed-off-by: Josh Boyer <jdub@us.ibm.com>

---
 include/asm-ppc/reg_booke.h |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- linux-2.6.orig/include/asm-ppc/reg_booke.h
+++ linux-2.6/include/asm-ppc/reg_booke.h
@@ -300,14 +300,14 @@ do {						\
 #define DBSR_IC		0x80000000	/* Instruction Completion */
 #define DBSR_BT		0x40000000	/* Branch taken */
 #define DBSR_TIE	0x10000000	/* Trap Instruction debug Event */
-#define DBSR_IAC1	0x00800000	/* Instruction Address Compare 1 Event */
-#define DBSR_IAC2	0x00400000	/* Instruction Address Compare 2 Event */
-#define DBSR_IAC3	0x00200000	/* Instruction Address Compare 3 Event */
-#define DBSR_IAC4	0x00100000	/* Instruction Address Compare 4 Event */
-#define DBSR_DAC1R	0x00080000	/* Data Address Compare 1 Read Event */
-#define DBSR_DAC1W	0x00040000	/* Data Address Compare 1 Write Event */
-#define DBSR_DAC2R	0x00020000	/* Data Address Compare 2 Read Event */
-#define DBSR_DAC2W	0x00010000	/* Data Address Compare 2 Write Event */
+#define DBSR_IAC1	0x04000000	/* Instruction Address Compare 1 Event */
+#define DBSR_IAC2	0x02000000	/* Instruction Address Compare 2 Event */
+#define DBSR_IAC3	0x00080000	/* Instruction Address Compare 3 Event */
+#define DBSR_IAC4	0x00040000	/* Instruction Address Compare 4 Event */
+#define DBSR_DAC1R	0x01000000	/* Data Address Compare 1 Read Event */
+#define DBSR_DAC1W	0x00800000	/* Data Address Compare 1 Write Event */
+#define DBSR_DAC2R	0x00400000	/* Data Address Compare 2 Read Event */
+#define DBSR_DAC2W	0x00200000	/* Data Address Compare 2 Write Event */
 #endif
 
 /* Bit definitions related to the ESR. */
