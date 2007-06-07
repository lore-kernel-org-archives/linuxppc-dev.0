Return-Path: <moilanen@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 91C85DDE00
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 07:27:17 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l57LREdO005498
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Jun 2007 17:27:14 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l57LREJo497414
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Jun 2007 17:27:14 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l57LRD7h013198
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Jun 2007 17:27:13 -0400
Subject: [PATCH 1/2] Donate dedicated CPU cycles
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18022.14166.83442.173369@cargo.ozlabs.ibm.com>
References: <1180638885.5756.11.camel@goblue>
	<18022.14166.83442.173369@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 16:27:11 -0500
Message-Id: <1181251632.5835.14.camel@goblue>
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

Rename the VPA's cpuctls_task_attrs field to a more accurate name.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

--

 include/asm-powerpc/lppaca.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: powerpc/include/asm-powerpc/lppaca.h
===================================================================
--- powerpc.orig/include/asm-powerpc/lppaca.h
+++ powerpc/include/asm-powerpc/lppaca.h
@@ -98,7 +98,7 @@ struct lppaca {
 	u64	saved_gpr5;		// Saved GPR5                   x30-x37
 
 	u8	reserved4;		// Reserved			x38-x38
-	u8	cpuctls_task_attrs;	// Task attributes for cpuctls  x39-x39
+	u8	donate_dedicated_cpu;	// Donate dedicated CPU cycles  x39-x39
 	u8	fpregs_in_use;		// FP regs in use               x3A-x3A
 	u8	pmcregs_in_use;		// PMC regs in use              x3B-x3B
 	volatile u32 saved_decr;	// Saved Decr Value             x3C-x3F
