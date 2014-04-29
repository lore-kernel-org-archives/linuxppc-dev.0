Return-Path: <jslaby@suse.cz>
Received: from ip4-83-240-18-248.cust.nbox.cz (ip4-83-240-18-248.cust.nbox.cz
 [83.240.18.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 79AA71400A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 17:50:39 +1000 (EST)
From: Jiri Slaby <jslaby@suse.cz>
To: rostedt@goodmis.org
Subject: [PATCH 1/2] ftrace: PPC, fix obsolete comment
Date: Tue, 29 Apr 2014 09:24:06 +0200
Message-Id: <1398756247-29536-1-git-send-email-jslaby@suse.cz>
Cc: jirislaby@gmail.com, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Frederic Weisbecker <fweisbec@gmail.com>, Jiri Slaby <jslaby@suse.cz>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_MCOUNT is not defined anymore, the corresponding #ifdef there
is CONFIG_FUNCTION_TRACER.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: <linuxppc-dev@lists.ozlabs.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
---
 arch/powerpc/kernel/entry_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 22b45a4955cd..f1f652a8f395 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -1457,4 +1457,4 @@ _GLOBAL(return_to_handler)
 	blr
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
-#endif /* CONFIG_MCOUNT */
+#endif /* CONFIG_FUNCTION_TRACER */
-- 
1.9.2
