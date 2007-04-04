Return-Path: <milindchoudhary@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 73C5CDDECE
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 02:36:37 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so698375ugf
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Apr 2007 09:36:35 -0700 (PDT)
Date: Wed, 4 Apr 2007 22:07:40 +0530
From: Milind Arun Choudhary <milindchoudhary@gmail.com>
To: kernel-janitors@lists.osdl.org
Subject: [KJ][PATCH]Unused ROUND_UP, NAME_OFFSET macro in arch/powerpc
Message-ID: <20070404163740.GA9830@arun.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Unused ROUND_UP, NAME_OFFSET  macro cleanup

Signed-off-by: Milind Arun Choudhary <milindchoudhary@gmail.com>

---
 sys_ppc32.c |    4 ----
 1 files changed, 4 deletions(-)


diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index 673e8d9..047246a 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -53,10 +53,6 @@
 #include <asm/ppc-pci.h>
 #include <asm/syscalls.h>
 
-/* readdir & getdents */
-#define NAME_OFFSET(de) ((int) ((de)->d_name - (char __user *) (de)))
-#define ROUND_UP(x) (((x)+sizeof(u32)-1) & ~(sizeof(u32)-1))
-
 struct old_linux_dirent32 {
 	u32		d_ino;
 	u32		d_offset;
-- 
Milind Arun Choudhary
