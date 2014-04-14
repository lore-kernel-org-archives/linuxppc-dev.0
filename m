Return-Path: <anton@samba.org>
Date: Mon, 14 Apr 2014 21:55:25 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 3/3] powerpc: Bump BOOT_COMMAND_LINE_SIZE to 2048
Message-ID: <20140414215525.332667a6@kryten>
In-Reply-To: <20140414215405.319725d5@kryten>
References: <20140414215405.319725d5@kryten>
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

Bump the boot wrapper BOOT_COMMAND_LINE_SIZE to match the
kernel.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

We export this in an ELF section so userspace tools can edit it.
We should be safe so long as we are only increasing it shouldn't we?

Index: b/arch/powerpc/boot/ops.h
===================================================================
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -15,7 +15,7 @@
 #include "types.h"
 #include "string.h"
 
-#define	BOOT_COMMAND_LINE_SIZE	512
+#define	BOOT_COMMAND_LINE_SIZE	2048
 #define	MAX_PATH_LEN		256
 #define	MAX_PROP_LEN		256 /* What should this be? */
 
