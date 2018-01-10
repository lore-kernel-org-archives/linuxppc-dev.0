Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGdt20t3GzF0c3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 17:10:49 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc: Cosmetic cleanup of cpuinfo_op
Date: Wed, 10 Jan 2018 17:10:14 +1100
Message-Id: <20180110061014.29181-3-benh@kernel.crashing.org>
In-Reply-To: <20180110061014.29181-1-benh@kernel.crashing.org>
References: <20180110061014.29181-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/setup-common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index c1df4ba0094c..9f9524bdd3f1 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -377,10 +377,10 @@ static void c_stop(struct seq_file *m, void *v)
 }
 
 const struct seq_operations cpuinfo_op = {
-	.start =c_start,
-	.next =	c_next,
-	.stop =	c_stop,
-	.show =	show_cpuinfo,
+	.start	= c_start,
+	.next	= c_next,
+	.stop	= c_stop,
+	.show	= show_cpuinfo,
 };
 
 void __init check_for_initrd(void)
-- 
2.14.3
