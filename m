Return-Path: <sfr@canb.auug.org.au>
From: sfr@canb.auug.org.au
To: paulus@samba.org
Subject: [PATCH 02/15] powerpc: move asm/suspend.h
Date: Wed, 05 Apr 2006 15:10:36 +1000
Message-Id: <11442138521003-git-send-email-sfr@canb.auug.org.au>
In-Reply-To: <11442138494042-git-send-email-sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
Reply-To: sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>

Since files in arch/powerpc now depend on asm/suspend.h,
move it to include/asm-powerpc.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

---

 include/asm-powerpc/suspend.h |   17 +++++++++++++++++
 include/asm-ppc/suspend.h     |   12 ------------
 2 files changed, 17 insertions(+), 12 deletions(-)
 create mode 100644 include/asm-powerpc/suspend.h
 delete mode 100644 include/asm-ppc/suspend.h

8d1f48e5eb94865c139b9c0ffd51ad50f991a1e6
diff --git a/include/asm-powerpc/suspend.h b/include/asm-powerpc/suspend.h
new file mode 100644
index 0000000..39fb2cd
--- /dev/null
+++ b/include/asm-powerpc/suspend.h
@@ -0,0 +1,17 @@
+#ifndef _ASM_POWERPC_SUSPEND_H
+#define _ASM_POWERPC_SUSPEND_H
+
+static inline int arch_prepare_suspend(void)
+{
+	return 0;
+}
+
+static inline void save_processor_state(void)
+{
+}
+
+static inline void restore_processor_state(void)
+{
+}
+
+#endif /* _ASM_POWERPC_SUSPEND_H */
diff --git a/include/asm-ppc/suspend.h b/include/asm-ppc/suspend.h
deleted file mode 100644
index 3df9f32..0000000
--- a/include/asm-ppc/suspend.h
+++ /dev/null
@@ -1,12 +0,0 @@
-static inline int arch_prepare_suspend(void)
-{
-	return 0;
-}
-
-static inline void save_processor_state(void)
-{
-}
-
-static inline void restore_processor_state(void)
-{
-}
-- 
1.2.4
