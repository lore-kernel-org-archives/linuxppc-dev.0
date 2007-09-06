Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2ABA4DDF15
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 03:47:00 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l86HkvDh019986
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Sep 2007 13:46:57 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l86Hkvlu550784
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Sep 2007 13:46:57 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l86HkkiT029005
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Sep 2007 13:46:57 -0400
Date: Thu, 6 Sep 2007 12:45:21 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/3] powerpc: prom_init whitespace cleanup, typo fix.
Message-ID: <20070906174521.GA21800@austin.ibm.com>
References: <20070906174416.GW4584@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070906174416.GW4584@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Whitespace cleanup: badly indented lines.
Typo in comment.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----

 arch/powerpc/kernel/prom_init.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6.22-git2/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-2.6.22-git2.orig/arch/powerpc/kernel/prom_init.c	2007-07-08 18:32:17.000000000 -0500
+++ linux-2.6.22-git2/arch/powerpc/kernel/prom_init.c	2007-08-28 16:40:26.000000000 -0500
@@ -1197,7 +1197,7 @@ static void __init prom_initialize_tce_t
 		if ((type[0] == 0) || (strstr(type, RELOC("pci")) == NULL))
 			continue;
 
-		/* Keep the old logic in tack to avoid regression. */
+		/* Keep the old logic intact to avoid regression. */
 		if (compatible[0] != 0) {
 			if ((strstr(compatible, RELOC("python")) == NULL) &&
 			    (strstr(compatible, RELOC("Speedwagon")) == NULL) &&
@@ -2224,7 +2224,7 @@ static void __init fixup_device_tree(voi
 
 static void __init prom_find_boot_cpu(void)
 {
-       	struct prom_t *_prom = &RELOC(prom);
+	struct prom_t *_prom = &RELOC(prom);
 	u32 getprop_rval;
 	ihandle prom_cpu;
 	phandle cpu_pkg;
@@ -2244,7 +2244,7 @@ static void __init prom_find_boot_cpu(vo
 static void __init prom_check_initrd(unsigned long r3, unsigned long r4)
 {
 #ifdef CONFIG_BLK_DEV_INITRD
-       	struct prom_t *_prom = &RELOC(prom);
+	struct prom_t *_prom = &RELOC(prom);
 
 	if (r3 && r4 && r4 != 0xdeadbeef) {
 		unsigned long val;
@@ -2277,7 +2277,7 @@ unsigned long __init prom_init(unsigned 
 			       unsigned long pp,
 			       unsigned long r6, unsigned long r7)
 {	
-       	struct prom_t *_prom;
+	struct prom_t *_prom;
 	unsigned long hdr;
 	unsigned long offset = reloc_offset();
 
@@ -2336,8 +2336,8 @@ unsigned long __init prom_init(unsigned 
 	/*
 	 * Copy the CPU hold code
 	 */
-       	if (RELOC(of_platform) != PLATFORM_POWERMAC)
-       		copy_and_flush(0, KERNELBASE + offset, 0x100, 0);
+	if (RELOC(of_platform) != PLATFORM_POWERMAC)
+		copy_and_flush(0, KERNELBASE + offset, 0x100, 0);
 
 	/*
 	 * Do early parsing of command line
