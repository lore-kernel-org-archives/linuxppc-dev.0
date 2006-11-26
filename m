Return-Path: <rutger@wingding.demon.nl>
Received: from post-25.mail.nl.demon.net (post-25.mail.nl.demon.net
	[194.159.73.195]) by ozlabs.org (Postfix) with ESMTP id 4432567BC1
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 07:08:44 +1100 (EST)
Date: Sun, 26 Nov 2006 21:08:38 +0100
From: Rutger Nijlunsing <rutger@nospam.com>
To: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [POWERPC] Add files build to .gitignore
Message-ID: <20061126200838.GA25645@nospam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Reply-To: linuxppc-dev@tux.tmfweb.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mostly taken from corresponding Makefile's make-clean rule.

Tested by (cross)compiling for $ARCH PPC and POWERPC and checking
output of git-status.

Signed-off-by: Rutger Nijlunsing <git-commit@tux.tmfweb.nl>
---

(This patch is against Paulus' git tree branch master)

---
 arch/powerpc/.gitignore         |    1 +
 arch/powerpc/boot/.gitignore    |    8 +++++++-
 arch/ppc/.gitignore             |    1 +
 arch/ppc/boot/images/.gitignore |    6 ++++++
 arch/ppc/boot/lib/.gitignore    |    3 +++
 arch/ppc/boot/utils/.gitignore  |    3 +++
 6 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/.gitignore b/arch/powerpc/.gitignore
new file mode 100644
index 0000000..a1a869c
--- /dev/null
+++ b/arch/powerpc/.gitignore
@@ -0,0 +1 @@
+include
diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
index 590e72f..0734b2f 100644
--- a/arch/powerpc/boot/.gitignore
+++ b/arch/powerpc/boot/.gitignore
@@ -19,9 +19,15 @@ kernel-vmlinux.strip.gz
 mktree
 uImage
 zImage
-zImage.vmode
+zImage.chrp
+zImage.coff
 zImage.coff.lds
 zImage.lds
+zImage.miboot
+zImage.pmac
+zImage.pseries
+zImage.sandpoint
+zImage.vmode
 zconf.h
 zlib.h
 zutil.h
diff --git a/arch/ppc/.gitignore b/arch/ppc/.gitignore
new file mode 100644
index 0000000..a1a869c
--- /dev/null
+++ b/arch/ppc/.gitignore
@@ -0,0 +1 @@
+include
diff --git a/arch/ppc/boot/images/.gitignore b/arch/ppc/boot/images/.gitignore
new file mode 100644
index 0000000..c7bba25
--- /dev/null
+++ b/arch/ppc/boot/images/.gitignore
@@ -0,0 +1,6 @@
+sImage
+vmapus
+vmlinux*
+miboot*
+zImage*
+uImage
\ No newline at end of file
diff --git a/arch/ppc/boot/lib/.gitignore b/arch/ppc/boot/lib/.gitignore
new file mode 100644
index 0000000..1629a61
--- /dev/null
+++ b/arch/ppc/boot/lib/.gitignore
@@ -0,0 +1,3 @@
+inffast.c
+inflate.c
+inftrees.c
diff --git a/arch/ppc/boot/utils/.gitignore b/arch/ppc/boot/utils/.gitignore
new file mode 100644
index 0000000..bbdfb3b
--- /dev/null
+++ b/arch/ppc/boot/utils/.gitignore
@@ -0,0 +1,3 @@
+mkprep
+mkbugboot
+mktree
-- 
1.4.4
