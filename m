Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 305FE67B79
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 23:10:00 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5FD9uX8010504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 09:09:57 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5FD9vvH173398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 09:09:57 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5FD9up2016122
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 09:09:57 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: enable CPU_FTR_CI_LARGE_PAGE for cell
Date: Thu, 15 Jun 2006 15:09:16 +0200
References: <17553.16736.157418.936815@cargo.ozlabs.ibm.com>
	<200606151503.11198.arnd.bergmann@de.ibm.com>
In-Reply-To: <200606151503.11198.arnd.bergmann@de.ibm.com>
MIME-Version: 1.0
Message-Id: <200606151509.16602.arnd.bergmann@de.ibm.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: torvalds@osdl.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Reflect the fact that the Cell Broadband Engine supports 64k
pages by adding the bit to the CPU features.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linus-2.6/include/asm-powerpc/cputable.h
===================================================================
--- linus-2.6.orig/include/asm-powerpc/cputable.h
+++ linus-2.6/include/asm-powerpc/cputable.h
@@ -329,7 +329,7 @@ extern void do_cpu_ftr_fixups(unsigned l
 #define CPU_FTRS_CELL	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
-	    CPU_FTR_CTRL | CPU_FTR_PAUSE_ZERO)
+	    CPU_FTR_CTRL | CPU_FTR_PAUSE_ZERO | CPU_FTR_CI_LARGE_PAGE)
 #define CPU_FTRS_COMPATIBLE	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2)
 #endif
