Return-Path: <bunk@kernel.org>
Received: from smtp6.pp.htv.fi (smtp6.pp.htv.fi [213.243.153.40])
	by ozlabs.org (Postfix) with ESMTP id 6481DDE063
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 04:18:46 +1000 (EST)
Date: Thu, 17 Jul 2008 21:18:28 +0300
From: Adrian Bunk <bunk@kernel.org>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: [2.6 patch] powerpc: remove duplicate 6xx option
Message-ID: <20080717181828.GA18326@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The real option is above in the same Kconfig file.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
2251e74345df51309579a0a5fd8339e2f14762b9 
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 5bc4b61..6489d57 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -84,9 +84,6 @@ config TUNE_CELL
 	  machines. When building a kernel that is supposed to run only
 	  on Cell, you should also select the POWER4_ONLY option.
 
-config 6xx
-	bool
-
 # this is temp to handle compat with arch=ppc
 config 8xx
 	bool
