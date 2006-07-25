Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 236AA67B7E
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Jul 2006 07:26:16 +1000 (EST)
Message-ID: <44C6877D.6060107@am.sony.com>
Date: Tue, 25 Jul 2006 14:05:01 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH] powerpc: minor comment fix for misc_64.S
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A minor comment fix for misc_64.S.

From: Takao Shinohara
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---

Index: a/arch/powerpc/kernel/misc_64.S
===================================================================
--- a.orig/arch/powerpc/kernel/misc_64.S	2006-07-25 12:38:44.000000000 -0700
+++ a/arch/powerpc/kernel/misc_64.S	2006-07-25 13:44:56.000000000 -0700
@@ -687,7 +687,7 @@
 	/* clear out hardware hash page table and tlb */
 	ld	r5,0(r27)		/* deref function descriptor */
 	mtctr	r5
-	bctrl				/* ppc_md.hash_clear_all(void); */
+	bctrl				/* ppc_md.hpte_clear_all(void); */

 /*
  *   kexec image calling is:
