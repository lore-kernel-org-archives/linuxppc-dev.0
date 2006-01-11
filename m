Return-Path: <galak@gate.crashing.org>
Date: Tue, 10 Jan 2006 22:12:23 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.44.0601102211530.15456-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: [PATCH] powerpc: Add some missing .gitignore's
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ignore generated files under arch/powerpc

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 4ef3ebb801e686338c5a8c87863887c54b2af02e
tree 384eb9502d8d4ef5d5452cfe7f43906366230454
parent 2c80aa14abcccdfdef2998ba78c299c33999c621
author Kumar Gala <galak@kernel.crashing.org> Tue, 10 Jan 2006 22:17:28 -0600
committer Kumar Gala <galak@kernel.crashing.org> Tue, 10 Jan 2006 22:17:28 -0600

 arch/powerpc/boot/.gitignore          |   20 ++++++++++++++++++++
 arch/powerpc/kernel/vdso32/.gitignore |    1 +
 arch/powerpc/kernel/vdso64/.gitignore |    1 +
 3 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
new file mode 100644
index 0000000..45c9ad2
--- /dev/null
+++ b/arch/powerpc/boot/.gitignore
@@ -0,0 +1,20 @@
+addnote
+infblock.c
+infblock.h
+infcodes.c
+infcodes.h
+inffast.c
+inffast.h
+inflate.c
+inftrees.c
+inftrees.h
+infutil.c
+infutil.h
+kernel-vmlinux.strip.c
+kernel-vmlinux.strip.gz
+uImage
+zImage
+zImage.vmode
+zconf.h
+zlib.h
+zutil.h
diff --git a/arch/powerpc/kernel/vdso32/.gitignore b/arch/powerpc/kernel/vdso32/.gitignore
new file mode 100644
index 0000000..e45fba9
--- /dev/null
+++ b/arch/powerpc/kernel/vdso32/.gitignore
@@ -0,0 +1 @@
+vdso32.lds
diff --git a/arch/powerpc/kernel/vdso64/.gitignore b/arch/powerpc/kernel/vdso64/.gitignore
new file mode 100644
index 0000000..3fd18cf
--- /dev/null
+++ b/arch/powerpc/kernel/vdso64/.gitignore
@@ -0,0 +1 @@
+vdso64.lds
