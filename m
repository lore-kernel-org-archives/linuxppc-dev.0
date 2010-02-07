Return-Path: <anton@ozlabs.org>
Date: Mon, 8 Feb 2010 10:07:36 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: powerpc: Make powerpc_firmware_features __read_mostly
Message-ID: <20100207230736.GG32246@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We use firmware_has_feature quite a lot these days, so it's worth putting
powerpc_firmware_features into __read_mostly.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/kernel/firmware.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/firmware.c	2010-02-05 14:57:48.579712760 +1100
+++ powerpc.git/arch/powerpc/kernel/firmware.c	2010-02-05 14:57:54.688461988 +1100
@@ -17,5 +17,5 @@
 
 #include <asm/firmware.h>
 
-unsigned long powerpc_firmware_features;
+unsigned long powerpc_firmware_features __read_mostly;
 EXPORT_SYMBOL_GPL(powerpc_firmware_features);
