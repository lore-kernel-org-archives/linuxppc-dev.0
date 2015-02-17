Return-Path: <kda@linux-powerpc.org>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2929F1A08B6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 18:00:55 +1100 (AEDT)
Received: by labgq15 with SMTP id gq15so34144848lab.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 23:00:51 -0800 (PST)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v2 4/6] ppc: bpf: rename bpf_jit_64.S to bpf_jit_asm.S
Date: Tue, 17 Feb 2015 10:04:41 +0300
Message-Id: <1424156683-2682-5-git-send-email-kda@linux-powerpc.org>
In-Reply-To: <1424156683-2682-1-git-send-email-kda@linux-powerpc.org>
References: <1424156683-2682-1-git-send-email-kda@linux-powerpc.org>
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
