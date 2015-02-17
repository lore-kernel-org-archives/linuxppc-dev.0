Return-Path: <kda@linux-powerpc.org>
Received: from mail-la0-f41.google.com (mail-la0-f41.google.com
 [209.85.215.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DEFA1A025C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 18:00:52 +1100 (AEDT)
Received: by labge10 with SMTP id ge10so33884555lab.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 23:00:49 -0800 (PST)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v2 2/6] ppc: bpf: add reqired opcodes for ppc32
Date: Tue, 17 Feb 2015 10:04:39 +0300
Message-Id: <1424156683-2682-3-git-send-email-kda@linux-powerpc.org>
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
 arch/powerpc/include/asm/ppc-opcode.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 03cd858..2eadde0 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -212,6 +212,8 @@
 #define PPC_INST_LWZ			0x80000000
 #define PPC_INST_STD			0xf8000000
 #define PPC_INST_STDU			0xf8000001
+#define PPC_INST_STW			0x90000000
+#define PPC_INST_STWU			0x94000000
 #define PPC_INST_MFLR			0x7c0802a6
 #define PPC_INST_MTLR			0x7c0803a6
 #define PPC_INST_CMPWI			0x2c000000
-- 
2.1.3
