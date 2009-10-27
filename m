Return-Path: <anton@ozlabs.org>
Date: Tue, 27 Oct 2009 15:52:24 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 6/6] powerpc: Export powerpc_debugfs_root
Message-ID: <20091027045224.GG3085@kryten>
References: <20091027044742.GB3085@kryten> <20091027044914.GC3085@kryten>
	<20091027045029.GD3085@kryten> <20091027045109.GE3085@kryten>
	<20091027045157.GF3085@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091027045157.GF3085@kryten>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Kernel modules should be able to place their debug output inside our powerpc
debugfs directory.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux.trees.git/arch/powerpc/kernel/setup-common.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/setup-common.c	2009-10-27 12:59:00.000000000 +1100
+++ linux.trees.git/arch/powerpc/kernel/setup-common.c	2009-10-27 12:59:15.000000000 +1100
@@ -660,6 +660,7 @@ late_initcall(check_cache_coherency);
 
 #ifdef CONFIG_DEBUG_FS
 struct dentry *powerpc_debugfs_root;
+EXPORT_SYMBOL(powerpc_debugfs_root);
 
 static int powerpc_debugfs_init(void)
 {
