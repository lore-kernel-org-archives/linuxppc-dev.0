Return-Path: <kda@linux-powerpc.org>
Received: from mail-la0-f49.google.com (mail-la0-f49.google.com
 [209.85.215.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A67C51A072E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 05:03:13 +1100 (AEDT)
Received: by labgf13 with SMTP id gf13so24617756lab.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Feb 2015 10:03:10 -0800 (PST)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 5/6] ppc: bpf: rename bpf_jit_64.S to bpf_jit_asm.S
Date: Sun, 15 Feb 2015 21:06:44 +0300
Message-Id: <1424023605-2416-6-git-send-email-kda@linux-powerpc.org>
In-Reply-To: <1424023605-2416-1-git-send-email-kda@linux-powerpc.org>
References: <1424023605-2416-1-git-send-email-kda@linux-powerpc.org>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
---
 arch/powerpc/net/Makefile                        | 2 +-
 arch/powerpc/net/{bpf_jit_64.S => bpf_jit_asm.S} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/powerpc/net/{bpf_jit_64.S => bpf_jit_asm.S} (100%)

diff --git a/arch/powerpc/net/Makefile b/arch/powerpc/net/Makefile
index 266b395..1306a58 100644
--- a/arch/powerpc/net/Makefile
+++ b/arch/powerpc/net/Makefile
@@ -1,4 +1,4 @@
 #
 # Arch-specific network modules
 #
-obj-$(CONFIG_BPF_JIT) += bpf_jit_64.o bpf_jit_comp.o
+obj-$(CONFIG_BPF_JIT) += bpf_jit_asm.o bpf_jit_comp.o
diff --git a/arch/powerpc/net/bpf_jit_64.S b/arch/powerpc/net/bpf_jit_asm.S
similarity index 100%
rename from arch/powerpc/net/bpf_jit_64.S
rename to arch/powerpc/net/bpf_jit_asm.S
-- 
2.1.3
