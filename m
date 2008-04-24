Return-Path: <galak@kernel.crashing.org>
Date: Thu, 24 Apr 2008 11:37:44 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: jk@ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [POWERPC] spufs: add .gitignore for spu_save_dump.h &
	spu_restore_dump.h
Message-ID: <Pine.LNX.4.64.0804241136310.22265@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/cell/spufs/.gitignore |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/cell/spufs/.gitignore

diff --git a/arch/powerpc/platforms/cell/spufs/.gitignore b/arch/powerpc/platforms/cell/spufs/.gitignore
new file mode 100644
index 0000000..a09ee8d
--- /dev/null
+++ b/arch/powerpc/platforms/cell/spufs/.gitignore
@@ -0,0 +1,2 @@
+spu_save_dump.h
+spu_restore_dump.h
-- 
1.5.4.1
