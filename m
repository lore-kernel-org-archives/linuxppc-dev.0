Return-Path: <anton@samba.org>
Date: Mon, 14 Apr 2014 21:54:52 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 2/3] powerpc: Bump COMMAND_LINE_SIZE to 2048
Message-ID: <20140414215452.058036b9@kryten>
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

I've had a report that the current limit is too small for
an automated network based installer. Bump it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/include/uapi/asm/setup.h b/arch/powerpc/include/uapi/asm/setup.h
index 552df83..0516e97 100644
--- a/arch/powerpc/include/uapi/asm/setup.h
+++ b/arch/powerpc/include/uapi/asm/setup.h
@@ -1 +1,6 @@
-#include <asm-generic/setup.h>
+#ifndef _UAPI_ASM_POWERPC_SETUP_H
+#define _UAPI_ASM_POWERPC_SETUP_H
+
+#define COMMAND_LINE_SIZE	2048
+
+#endif /* _UAPI_ASM_POWERPC_SETUP_H */
