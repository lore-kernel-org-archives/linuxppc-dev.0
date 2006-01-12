Return-Path: <trini@kernel.crashing.org>
Date: Thu, 12 Jan 2006 14:25:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Message-ID: <20060112212550.GJ27215@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH] Remove bzImage target
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since the documentation no longer tells people to 'make bzImage', and
with the previous patch nothing more than 'make' is required to get the
right bootable images (just like on i386 now), this removes the bzImage
-> zImage target redirect on ARCH=powerpc

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 5f80e58..ad19028 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -148,9 +150,6 @@ all: $(KBUILD_IMAGE)
 
 CPPFLAGS_vmlinux.lds	:= -Upowerpc
 
-# All the instructions talk about "make bzImage".
-bzImage: zImage
-
 BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm uImage
 
 .PHONY: $(BOOT_TARGETS)

-- 
Tom Rini
http://gate.crashing.org/~trini/
