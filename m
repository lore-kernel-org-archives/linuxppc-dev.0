Return-Path: <anton@samba.org>
Date: Wed, 31 Jul 2013 16:31:26 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mikey@neuling.org
Subject: [PATCH] powerpc: On POWERNV enable PPC_DENORMALISATION by default
Message-ID: <20130731163126.051976be@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We want PPC_DENORMALISATION enabled when POWERNV is enabled,
so update the Kconfig.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/Kconfig
===================================================================
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -566,7 +566,7 @@ config SCHED_SMT
 config PPC_DENORMALISATION
 	bool "PowerPC denormalisation exception handling"
 	depends on PPC_BOOK3S_64
-	default "n"
+	default "y" if PPC_POWERNV
 	---help---
 	  Add support for handling denormalisation of single precision
 	  values.  Useful for bare metal only.  If unsure say Y here.
