Return-Path: <bunk@stusta.de>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with SMTP id 3884F67C2B
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 15:17:27 +1100 (EST)
Date: Wed, 22 Nov 2006 05:17:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: [2.6 patch] arch/powerpc/Kconfig: fix the EMBEDDED6xx dependencies
Message-ID: <20061122041727.GA5200@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch changes the EMBEDDED6xx dependencies to the equivalent 
dependency that seems to have been intended.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/arch/powerpc/Kconfig.old	2006-11-22 02:24:21.000000000 +0100
+++ linux-2.6.19-rc5-mm2/arch/powerpc/Kconfig	2006-11-22 02:24:34.000000000 +0100
@@ -369,7 +369,7 @@ config PPC_MULTIPLATFORM
 
 config EMBEDDED6xx
 	bool "Embedded 6xx/7xx/7xxx-based board"
-	depends on PPC32 && (BROKEN||BROKEN_ON_SMP)
+	depends on PPC32 && BROKEN_ON_SMP
 
 config APUS
 	bool "Amiga-APUS"
