Return-Path: <trini@kernel.crashing.org>
Date: Thu, 12 Jan 2006 14:23:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Message-ID: <20060112212319.GI27215@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH] Add zImage / uImage to default builds
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds uImage and zImage to the list of default build targets on
ARCH=powerpc to match ARCH=ppc

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 5f80e58..ad19028 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -60,6 +60,8 @@ endif
 
 LDFLAGS_vmlinux	:= -Bstatic
 
+all: uImage zImage
+
 # The -Iarch/$(ARCH)/include is temporary while we are merging
 CPPFLAGS-$(CONFIG_PPC32) := -Iarch/$(ARCH) -Iarch/$(ARCH)/include
 AFLAGS-$(CONFIG_PPC32)	:= -Iarch/$(ARCH)

-- 
Tom Rini
http://gate.crashing.org/~trini/
